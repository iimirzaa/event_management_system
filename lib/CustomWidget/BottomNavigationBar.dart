import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
Widget bottomAppBar(){
  return BottomAppBar(
    color: Color(0xFF1F1C2C),
    notchMargin: 5.0,
    height: 40.h,
    elevation: 4,
    shape: CircularNotchedRectangle(),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Icon(Icons.home,color: Colors.white,size: 30.sp,),
        Icon(Icons.event,color: Colors.white,size: 30.sp,),
        Icon(Icons.notifications,color: Colors.white,size: 30.sp,),
        GestureDetector(
            onTap: (){},
            child: Icon(Icons.person,color: Colors.white,size: 30.sp,)),


      ],
    ),

  );
}
