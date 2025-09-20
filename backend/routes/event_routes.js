import express from 'express';
import {createEvent, loadEvent} from '../providers/event_provider.js';
const event=express.Router();
event.post('/createEvent',async(req,res)=>{
    const {eventName,category,service,capacity,street,town,city}=req.body;
    const authorization=req.headers['authorization'];
    console.log(req.body);
   
    if(eventName===""||category===""||service===""||capacity===""||street===""||town===""||city===""){
        res.status(409).send({success:false,message:"Invalid Credentials"});
    }else{
        try{    
            console.log(eventName);
        const response=  await createEvent(eventName,category,service,capacity,street,town,city,authorization);
        if (response.success) {
        res.status(200).send({ success: response.success, message: response.message })
      } else {
        res.status(400).send({ success: response.success, message: response.message })
      }

        }catch(e){
         res.status(500).send({ success: false, message: "Error while creating event" })
        }
    }

})
event.get('/loadEvent',async(req,res)=>{
    try{    
        console.log("Load Events called");
        const response=  await loadEvent(req.headers['authorization']);
        console.log(response);
        if (response.success) {
        res.status(200).send({ success: response.success, message: response.message ,events:response.events})
      } else {
        res.status(400).send({ success: response.success, message: response.message })
      }

        }catch(e){
         res.status(500).send({ success: false, message: "Error while fetching events" })
        }
})
export default event;