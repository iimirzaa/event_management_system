import express from 'express';
import { createEvent, loadEvent,loadOrganizerEvent,bookEvent } from '../providers/event_provider.js';
import { upload } from '../middleware/multer_middleware.js';
import { UploadOnCloudinary } from '../providers/cloudinary_provider.js';
const event = express.Router();
event.post('/createEvent', upload.array('images'), async (req, res) => {

  const { eventName, category, service, capacity, street, town, city } = req.body;
  const authorization = req.headers['authorization'];
  console.log(authorization);

  if (eventName === "" || category === "" || service === "" || capacity === "" || street === "" || town === "" || city === "") {
    res.status(409).send({ success: false, message: "Invalid Credentials" });
  } else {
    try {
      let imageUrls = [];
      if (req.files && req.files.length > 0) {
        for (let file of req.files) {
          const uploadedUrl = await UploadOnCloudinary(file.path);
          console.log(uploadedUrl);
          if (uploadedUrl) imageUrls.push(uploadedUrl);
        }
      }
      const response = await createEvent(eventName, category, service, capacity, street, town, city, authorization,imageUrls);
      if (response.success) {
        res.status(200).send({ success: response.success, message: response.message })
      } else {
        res.status(400).send({ success: response.success, message: response.message })
      }

    } catch (e) {
      console.log(e);
      res.status(500).send({ success: false, message: "Error while creating event" })
    }
  }

})
event.get('/loadEvent', async (req, res) => {
  try {
    console.log("Load Events called");
    const response = await loadEvent(req.headers['authorization']);
    console.log(response);
    if (response.success) {
      res.status(200).send({ success: response.success, message: response.message, events: response.events })
    } else {
      res.status(400).send({ success: response.success, message: response.message })
    }

  } catch (e) {
    res.status(500).send({ success: false, message: "Error while fetching events" })
  }
})
event.get('/loadOrganizerEvent', async (req, res) => {
  try {
    console.log("Load Organizer Events called");
    const response = await loadOrganizerEvent(req.headers['authorization']);
    console.log(response.events);
    if (response.success) {
      res.status(200).send({ success: response.success, message: response.message, events: response.events })
    } else {
      res.status(400).send({ success: response.success, message: response.message })
    }

  } catch (e) {
    res.status(500).send({ success: false, message: "Error while fetching events" })
  }
})
event.post('/bookEvent', async (req, res) => {
  try {
    console.log("Book Events called");
    console.log(req.body);
    const { eventId, category, service, capacity, details } = req.body;
    const response = await bookEvent(eventId,category,service,capacity,details,req.headers['authorization']);
    console.log(response);
    if (response.success) {
      res.status(200).send({ success: response.success, message: response.message, events: response.events })
    } else {
      res.status(400).send({ success: response.success, message: response.message })
    }

  } catch (e) {
    console.log(e);
    res.status(500).send({ success: false, message: "Error while booking events" })
  }
})
export default event;