
import { messaging } from 'firebase-admin';
import { SignUp, sendotp, verifyotp, login } from '../providers/auth_provider.js'
import express from 'express';

const auth = express.Router();
auth.post('/signUp', async (req, res) => {
  const { username, email, password, role } = req.body;
  console.log(req.body);
  if (username === "" || email === "" || password === "", role === "") {
    res.status(400).send({ success: false, message: "Invalid Credentials recieved" })
  } else {
    try {
      const response = await SignUp(username, email, password, role);
      if (response.success) {
        res.status(200).send({ success: response.success, message: response.message })
      } else {
        res.status(400).send({ success: response.success, message: response.message })
        console.log(response.message);
      }
    } catch (e) {
      console.log("Following error occured", e)
      res.status(500).send({ success: false, message: "Error while sending otp" })
    }
  }


})
auth.post('/login', async (req, res) => {
  const { email, password, role } = req.body;
  if (email === '', password === '', role === '') {
    res.status(400).send({ success: false, message: "Invalid Credentials" })
  } try {
    const response = await login(email, password, role);
    if (response.success) {
      res.status(200).send({ success: true, message: response.message })
    } else {
      res.status(401).send({ success: false, message: response.message })
    }

  } catch (e) {
    res.status(500).status({ success: false, message: "There was error was logging in!" })

  }
})
auth.post('/sendOtp', async (req, res) => {
  const { email } = req.email;
  if (!email || email === "") {
    res.status(400).send({ message: "Invalid Email address" })
  } else {
    try {
      const response = await sendotp(email);
      if (response.success) {
        res.status(200).send({ success: response.success, message: response.message })
      } else {
        res.status(400).send({ success: response.success, message: response.message })
      }

    } catch (e) {
      res.status(500).send({ success: false, message: "Error while sending OTP" })
    }
  }

})
auth.post('/verifyOtp', async (req, res) => {
  const { email, otp } = req.body;
  if (email === '' || otp === '') {
    res.status(400).send({ success: false, message: "Please Provide a valid OTP" })
  }
  try {
    const response = await verifyotp(email, otp);
    if (response.success) {
      res.status(200).send({ success: response.success, message: response.message });
    } else {
      res.status(401).send({ success: response.success, message: response.message })
    }

  } catch (e) {
    res.status(500).send({ success: false, message: "There was error while verifying OTP" })
  }
})
export default auth;

