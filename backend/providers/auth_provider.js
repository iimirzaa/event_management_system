
import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import { firestore, auth } from '../firebase/firebase_admin.js';
import { sendmail } from '../providers/email_provider.js'
import bcrypt, { hash } from "bcrypt";
import firebase from "firebase/compat/app";
async function SignUp(username, email, password, role) {
    try {
        const existinguser = await firestore.collection('user').where('email', '==', email).get();
        if (!existinguser.empty) {
            const userDoc = existinguser.docs[0];
            const userData = userDoc.data();
            if (userData.isverified) {
                return ({ success: false, message: "User already exists with that email address." })
            } else if (!userData.isverified) {
                const otp = await sendmail(userData.email);
                const hashedpassword = await bcrypt.hash(password, 12);
                await firestore.collection('user').doc(userDoc.id).update({
                    fullname: username,
                    role: role,
                    hashedpassword: hashedpassword,
                    otp: otp,
                    otp_expires_at: new Date(Date.now() + 5 * 60 * 1000)
                });
                return ({ success: true, message: "Sign up successful" })
            }
        }
        const hashedpassword = await bcrypt.hash(password, 12);
        const otpExpiresAt = new Date(Date.now() + 5 * 60 * 1000);
        const otp = await sendmail(email);
        const userId = uuidv4();
        await firestore.collection('user').doc(userId).set({
            fullname: username,
            email: email,
            role: role,
            hashedpassword: hashedpassword,
            otp: otp,
            isverified: false,
            otp_expires_at: otpExpiresAt,
            created_at: new Date().toISOString(),

        })
        return ({ success: true, message: "sign up successful" })

    } catch (e) {
        console.log(e)
        return ({ success: false, message: "Sign Up failed!" })
    }

}
async function login(email, password, role) {
    try {
        const user = await firestore.collection('user').where('email', '==', email).get();
        if (!user.empty) {
            const userDoc = user.docs[0];
            const userData = userDoc.data();
            console.log(userData);
            const isMatch = await bcrypt.compare(password, userData.hashedpassword);
            if (isMatch && userData.role == role && userData.isverified == true) {
                const payload = {
                    uid: userDoc.id,
                    role: userData.role,
                    name: userData.fullname,
                    email: userData.email,
                }
                const token = jwt.sign(payload, process.env.SECRETKEY, {
                    algorithm: "HS512",
                    expiresIn: "7d",

                })
                const decoded = jwt.decode(token);

                console.log("exp (seconds):", decoded.exp);
                console.log("exp (date):", new Date(decoded.exp * 1000))
                return ({ success: true, message: "Login Successful!", token: token })
            } else if (userData.isverified == false) {
                return ({ success: false, message: "Kindly verify your email via OTP" })
            }
            return ({ success: false, message: "Login Failed!" })
        }
    } catch (e) {
        return ({ success: false, message: "There was error wile logging in!" })

    }

}
async function sendotp(email) {
    try {
        const existinguser = await firestore.collection('user').where('email', '==', email).get();
        if (existinguser.empty) {
            return ({
                success: false, message: "User not found"
            });
        } else {
            const otp = await sendmail(email);
            await firestore.collection('user').doc(existinguser.docs[0].id).update({
                otp: otp,
                otp_expires_at: new Date(Date.now() + 5 * 60 * 1000)
            })
            return ({ success: true, message: "OTP sent to email successfully" })
        }
    } catch (e) {
        return ({ success: false, message: "There was error while sending otp" })
    }

}
async function verifyotp(email, otp) {
    try {
        const existinguser = await firestore.collection('user').where('email', '==', email).get();
        if (existinguser.empty) {
            return ({ success: false, message: "User not found" })
        }
        const userDoc = existinguser.docs[0];
        console.log(userDoc);
        const userData = userDoc.data();
        const now = new Date();
        if (userData.otp == otp && userData.otp_expires_at.toDate() > now) {
            await firestore.collection('user').doc(userDoc.id).update({
                isverified: true
            });
            return ({ success: true, message: "OTP verified successfully!" })
        } else {
            console.log('failed')
            return ({ success: false, message: "Incorrect OTP!\nor Timeout" })
        }
    } catch (e) {
        console.log(e);
        return ({ success: false, message: "OTP verification failed" })
    }

}
async function changePassword(email, password, authorization) {
    try {
        const hashedpassword = await bcrypt.hash(password, 12);
        if (authorization && authorization !== '') {
            const token = jwt.verify(authorization, process.env.SECRETKEY);
            const uid = token.uid;
            const userDoc = await firestore.collection('user').doc(uid).get();
            if (!userDoc.exists) {
                return ({ success: false, message: "User not found" });
            }
            await firestore.collection('user').doc(uid).update({
                hashedpassword: hashedpassword
            });
            return ({ success: true, message: 'Password has been changed' });



        } else {
            console.log('starting to find doc');
            const existinguser = await firestore.collection('user').where('email', '==', email).get();
            console.log(existinguser.docs[0]);
            if (!existinguser.docs[0].data().isverified) {

                return ({ success: false, message: 'Please Complete Sign Up process!' });
            }
            await firestore.collection('user').doc(existinguser.docs[0].id).update({
                hashedpassword: hashedpassword
            });

            return ({ success: true, message: 'Password has been changed' });
        }
    }

    catch (e) {
        console.log(e);
        return ({ success: false, message: "There was error during password changing" })
    }
}
export { SignUp, sendotp, verifyotp, login, changePassword }
