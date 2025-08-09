import admin from "firebase-admin";
import dotenv from 'dotenv';
dotenv.config();

import serviceAccount  from "../config/event-management-system-68a02-firebase-adminsdk-fbsvc-6f1d883b72.json" assert{type:'json'};

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),

});
const auth = admin.auth();

export default auth;
