import express from 'express'
import dotenv from "dotenv"
import auth from './routes/auth.js'
import event from './routes/event_routes.js'

const app=express();
dotenv.config();
app.use(express.urlencoded({extended:true}));
app.use(express.json());
app.use('/api/auth',auth);
app.use('/api/event',event)
app.listen(process.env.PORT,(req,res)=>{
    console.log("Server created Successfully!")
   
})