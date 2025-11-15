import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import dotenv from "dotenv"
import { firestore, auth } from '../firebase/firebase_admin.js';
import { sendmail } from '../providers/email_provider.js'
import { UploadOnCloudinary } from '../providers/cloudinary_provider.js';
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

            });
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
            const dateStr = now.toLocaleString('en-US', options);
            const notifiref = firestore.collection('user').doc(userDoc.id).collection('Notification');
            notifiref.add({
                message: `An event ${eventname} was created on ${dateStr}`,
                created_at: new Date().toISOString(),
            });
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
        let bookedId = [];
        let bookedEvents = [];
        let events = [];

        const userDoc = await firestore.collection("user").doc(uid).get();
        if (!userDoc.exists) {
            return { success: false, message: "UnAuthorized User" };
        }

        const [snapshot, snapshotBookedEvents] = await Promise.all([
            firestore.collection("events").get(),
            firestore.collection("user").doc(uid).collection("data").doc("bookedEvents").get()
        ]);

        // Get all events
        events = snapshot.docs.map(doc => ({
            id: doc.id,
            ...doc.data()
        }));

        let bookedEventData = [];
        if (snapshotBookedEvents.exists) {
            const data = snapshotBookedEvents.data();
            bookedEventData = Array.isArray(data.bookedEvents) ? data.bookedEvents : [];
            bookedId = bookedEventData.map(event => event.eventId).filter(id => id);
        }

        // Fetch booked event documents
        await Promise.all(
            bookedId.map(async (id) => {
                const doc = await firestore.collection("events").doc(id).get();
                if (doc.exists) {
                    bookedEvents.push({ id: doc.id, ...doc.data() });
                }
            })
        );

        // Combine all details
        const allBookedEventDetails = await Promise.all(
            bookedEventData.map(async (bEvent) => {
                const eventData = bookedEvents.find(e => e.id === bEvent.eventId);
                if (!eventData) return null;

                const organizerDoc = await firestore.collection("user").doc(eventData.uid).get();
                const organizerName = organizerDoc.exists ? organizerDoc.data().fullname : "Unknown Organizer";

                return {
                    bookingId: bEvent.bookingId, // you can adjust this as needed
                    eventId: bEvent.eventId,
                    eventname: eventData.eventname,
                    organizerName,
                    images: eventData.images,
                    city: eventData.city,
                    location: `${eventData.street}, ${eventData.town}`,
                    // From booking details
                    capacity: bEvent.capacity,
                    service: bEvent.service,
                    additionalInfo: bEvent.details,
                };
            })
        );

        console.log("All Combined Booked Events:", allBookedEventDetails.filter(Boolean));

        return {
            success: true,
            message: "Events loaded successfully",
            bookedEvents: allBookedEventDetails.filter(Boolean),
            events: events
        };

    } catch (e) {
        console.error(e);
        return { success: false, message: "Error while fetching events" };
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

        if (!userDoc.exists) {
            return ({ success: false, message: "UnAuthorized User" });
        } else {
            const eventReference = firestore.collection('user').doc(uid).collection('data').doc('bookedEvents');

            await firestore.runTransaction(async (transaction) => {
                const doc = await transaction.get(eventReference);
                const newBookedEventRef = firestore.collection('bookedEvents').doc();
                const bookedEventId = newBookedEventRef.id;

                // Data for booked event
                const newBookedEventData = {
                    bookingId: bookedEventId,
                    uid,
                    eventId,
                    category,
                    capacity,
                    service,
                    details,
                    createdAt: new Date()
                };

                // Save in main collection
                await newBookedEventRef.set(newBookedEventData);

                if (!doc.exists) {
                    transaction.set(eventReference, {
                        bookedEvents: [newBookedEventData],
                    });
                } else {
                    const currentEvents = doc.data().bookedEvents || [];
                    currentEvents.push(newBookedEventData);
                    transaction.update(eventReference, { bookedEvents: currentEvents });
                }
            });
            const now = new Date();
            const options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric', hour: '2-digit', minute: '2-digit' };
            const dateStr = now.toLocaleString('en-US', options);
            const notifiref = firestore.collection('user').doc(userDoc.id).collection('Notification');
            notifiref.add({
                message: `An event ${eventId} was booked  on  ${dateStr}`,
                created_at: new Date().toISOString(),
            });

            return ({ success: true, message: "Event booked Successfully" });
        }

    } catch (e) {
        console.log(e);
        return ({ success: false, message: 'There was an error while booking event' });
    }
}
async function loadNotifications(authorization) {
    try {
        const token = jwt.verify(authorization, process.env.SECRETKEY);
        const uid = token.uid;

        const userDoc = await firestore.collection("user").doc(uid).get();
        if (!userDoc.exists) {

            return ({ success: false, message: "UnAuthorized User" });
        } else {
            console.log("fetching")
            const snapshot = await firestore.collection('user').doc(uid).collection('Notification').get();

            const notifications = snapshot.docs.map(doc => ({
                id: doc.id,
                ...doc.data()
            }));


            return ({ success: true, message: "Organizer Events loaded Successfully", notifications: notifications });
        }

    } catch (e) {
        console.log(e);
        return ({ success: false, message: "Error while fetching Organizer events" });
    }
}
async function uploadProfilePic(url, authorization) {
    try {
        const token = jwt.verify(authorization, process.env.SECRETKEY);
        const uid = token.uid;
        const userDoc = await firestore.collection("user").doc(uid).get();
        if (!userDoc.exists) {
            return ({ success: false, message: "UnAuthorized User" });
        } else {
            if (!url) {
                console.error("Upload failed — Cloudinary returned undefined URL");
                return { success: false, message: "Image upload failed" };
            }
            await firestore.collection('user').doc(uid).update({
                profilePic: url,
                hasprofilepic: true
            });

            return ({ success: true, message: "Profile Picture Uploaded Successfully", });
        }

    }
    catch (e) {
        console.log(e);
        return ({ success: false, message: "Error while uploading profile picture" });
    }

}
export { createEvent, loadEvent, loadOrganizerEvent, bookEvent, loadNotifications, uploadProfilePic }