import { v4 as uuidv4 } from "uuid";
import jwt from "jsonwebtoken";
import { firestore, auth } from '../firebase/firebase_admin.js';
import { sendmail } from '../providers/email_provider.js'
import bcrypt from "bcrypt";
import firebase from "firebase/compat/app";
async function  createEvent(eventname,category,service,capacity,street,city,town) {
    
}
export {createEvent}