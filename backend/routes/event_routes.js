import express from 'express';
import {createEvent} from '../providers/event_provider.js';
const event=express.Router();
event.post('/createEvent',async(req,res)=>{
    const {eventname,category,service,capacity,street,town,city}=req.body;
    console.log(req.headers);

    console.log(authorization);
    if(eventname===""||category===""||service===""||capacity===""||street===""||town===""||city===""){
        res.status(409).send({success:false,message:"Invalid Credentials"});
    }else{
        try{
          await createEvent(eventname,capacity,category,city,street,town,service,authorization);

        }catch(e){

        }
    }

})
export default event;