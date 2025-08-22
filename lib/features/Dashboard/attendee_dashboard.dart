import 'package:event_management_system/CustomWidget/CustomCard.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AttendeeDashboard extends StatefulWidget {
  const AttendeeDashboard({super.key});

  @override
  State<AttendeeDashboard> createState() => _AttendeeDashboardState();
}

class _AttendeeDashboardState extends State<AttendeeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: Text(
          "Welcome ",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF1f1c2c),
                Color(0xFF928dab),
              ], // white → light gray
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Form(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search here",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFF1F1C2C),
                            width: 5,
                            style: BorderStyle.solid
                          )
                        ),
                        suffixIcon: Icon(Icons.search_outlined),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                    text: "Recommended Venues",
                    color: Color(0xFFFF6F61),
                    weight: FontWeight.w500,
                    size: 20.sp,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomCard()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
