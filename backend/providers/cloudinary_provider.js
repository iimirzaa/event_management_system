import { v2 as cloudinary } from 'cloudinary';
import fs from 'fs';
cloudinary.config({ 
  cloud_name:process.env.CLOUDINARY_CLOUD_NAME, 
  api_key: process.env.CLOUDINARY_API_KEY, 
  api_secret: process.env.CLOUDINARY_SECRET_KEY
});

const UploadOnCloudinary=async (LocalFilePath)=>{
    console.log(LocalFilePath)
    try {
        if(!LocalFilePath){
            retrun ({success:false,message:"File Path not found"});
        }
        const response=await cloudinary.uploader.upload(LocalFilePath,({
            resource_type:"image",
            folder:"event_images"
        }))
         fs.unlinkSync(LocalFilePath);
        return response.secure_url;
    } catch (error) {
          console.error("Cloudinary upload error:", err);
          fs.unlinkSync(LocalFilePath);
          return null;
    }
}
export {UploadOnCloudinary};