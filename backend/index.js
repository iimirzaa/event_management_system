const express=require('express')
const app=express();
const dotenv=require("dotenv")
dotenv.config();
app.use(express.urlencoded({extend:true}));
app.use(express.json());
app.listen(3000,(req,res)=>{
    console.log("Server created Successfully!")
})