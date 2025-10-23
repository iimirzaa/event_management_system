import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import dotenv from "dotenv"
import { firestore, auth } from '../firebase/firebase_admin.js';
import { sendmail } from '../providers/email_provider.js'
import bcrypt from "bcrypt";
import firebase from "firebase/compat/app";
import { Transaction } from "firebase-admin/firestore";
dotenv.config();
async function createEvent(eventname, category, service, capacity, street, town, city, authorization, imageUrls) {
    try {
        console.log(eventname, capacity, category, service, street, city, town, authorization);
        const token = jwt.verify(authorization, process.env.SECRETKEY);
        const uid = token.uid;


        const userDoc = await firestore.collection("user").doc(uid).get();
        console.log(userDoc.uid);
        console.log(token['uid'])
        console.log(userDoc);
        if (!userDoc.exists) {
            return ({ success: false, message: "UnAuthorized User" });
        } else {
            const eventReference = await firestore.collection('user').doc(token.uid).collection('data').doc('events');
            await firestore.runTransaction(async (transaction) => {
                const doc = await transaction.get(eventReference);
                if (!doc.exists) {
                    console.log("No docunment found");
                    transaction.set(eventReference, {
                        events: [{ eventname, category, capacity, street, town, city, service, images: imageUrls, createdAt: new Date() }],
                    });
                    await firestore.collection('events').doc().set({
                        eventId: doc.id,
                        uid: uid,
                        eventname: eventname,
                        category: category,
                        capacity: capacity,
                        street: street,
                        town: town,
                        service: service,
                        city: city,
                        images: imageUrls,
                        createdAt: new Date()

                    })
                } else {
                    const currentEvents = doc.data().events || [];
                    currentEvents.push({ eventname, category, capacity, street, town, city, service, images: imageUrls, createdAt: new Date() });

                    transaction.update(eventReference, { events: currentEvents });
                    await firestore.collection('events').doc().set({
                        eventId: doc.id,
                        uid: uid,
                        eventname: eventname,
                        category: category,
                        capacity: capacity,
                        street: street,
                        town: town,
                        service: service,
                        city: city,
                        images: imageUrls,
                        createdAt: new Date()

                    })
                }

            })
            return ({ success: true, message: "Event Created Successfully" });
        }


    } catch (e) {
        console.log(e);
        retrun({ success: false, message: 'There was an error while creating event' });
    }


}
async function loadEvent(authorization) {
    try {
        const token = jwt.verify(authorization, process.env.SECRETKEY);
        const uid = token.uid;


        const userDoc = await firestore.collection("user").doc(uid).get();
        if (!userDoc.exists) {
            return ({ success: false, message: "UnAuthorized User" });
        } else {
            const snapshot = await firestore.collection('events').get();
            const events = snapshot.docs.map(doc => ({
                id: doc.id,
                ...doc.data()
            }));


            return ({ success: true, message: "Events loaded Successfully", events: events });
        }

    } catch (e) {
        return ({ success: false, message: "Error while fetching events" });
    }
}
async function loadOrganizerEvent(authorization) {
    try {
        const token = jwt.verify(authorization, process.env.SECRETKEY);
        const uid = token.uid;


        const userDoc = await firestore.collection("user").doc(uid).get();
        if (!userDoc.exists) {
            return ({ success: false, message: "UnAuthorized User" });
        } else {
            const docRef = await firestore.collection('user').doc(uid).collection('data').doc('events').get();
            const docData = docRef.data();

            // const events = snapshot.docs.map(doc => ({
            //     id: doc.id,
            //     ...doc.data()
            // }));


            return ({ success: true, message: "Organizer Events loaded Successfully", events: docData });
        }

    } catch (e) {
        console.log(e);
        return ({ success: false, message: "Error while fetching Organizer events" });
    }
}
async function bookEvent(eventId, category, service, capacity, details, authorization) {
    try {
        const token = jwt.verify(authorization, process.env.SECRETKEY);
        const uid = token.uid;
        const userDoc = await firestore.collection("user").doc(uid).get();
        console.log(userDoc.uid);
        console.log(token['uid'])
        console.log(userDoc);
        if (!userDoc.exists) {
            return ({ success: false, message: "UnAuthorized User" });
        } else {
            const eventReference = await firestore.collection('user').doc(token.uid).collection('data').doc('bookedEvents');
            await firestore.runTransaction(async (transaction) => {
                const doc = await transaction.get(eventReference);
                if (!doc.exists) {
                    console.log("No docunment found");
                    transaction.set(eventReference, {
                        bookedEvents: [{ eventId, category, capacity, service, details, createdAt: new Date() }],
                    });
                    await firestore.collection('bookedEvents').doc().set({
                        
                        uid: uid,
                        eventId: eventId,
                        category: category,
                        capacity: capacity,
                        service: service,
                        details: details,
                        createdAt: new Date()

                    })
                } else {
                    const currentEvents = doc.data().bookedEvents || [];
                    currentEvents.push({ eventId, category, capacity, service, details, createdAt: new Date() });

                    transaction.update(eventReference, { bookedEvents: currentEvents });
                    await firestore.collection('bookedEvents').doc().set({
                        uid: uid,
                        eventId: eventId,
                        category: category,
                        capacity: capacity,

                        service: service,
                        details: details,

                        createdAt: new Date()

                    })
                }

            })
            return ({ success: true, message: "Event booked Successfully" });
        }


    } catch (e) {
        console.log(e);
        retrun({ success: false, message: 'There was an error while booking event' });
    }


}

export { createEvent, loadEvent, loadOrganizerEvent,bookEvent }