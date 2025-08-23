import 'package:event_management_system/CustomWidget/CustomButton.dart';
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
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(20.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10.h),
                  Form(
                    child: TextFormField(
                      onTapOutside: (event) {
                        FocusScope.of(context).unfocus();
                      },
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        hintText: "Search here",
                        hintStyle: TextStyle(
                          color: Colors.black87,
                          fontSize: 15.sp,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 14.h,
                          horizontal: 18.w,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFF1F1C2C).withOpacity(0.5),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFFFF6f61),
                            width: 2,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 10.w),
                          child: Icon(
                            Icons.search_outlined,
                            color: Color(0xFF1F1C2C),
                            size: 22.sp,
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white24,
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  ElevatedButton.icon(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                        ),
                        builder: (context) => Padding(
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.h),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Category",
                                ),
                                items:
                                    [
                                          "Birthday",
                                          "Wedding",
                                          "Corporate",
                                          "Private Party",
                                        ]
                                        .map(
                                          (cat) => DropdownMenuItem(
                                            value: cat,
                                            child: Text(cat),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {},
                              ),
                              DropdownButtonFormField<String>(
                                decoration: InputDecoration(
                                  labelText: "Location",
                                ),
                                items:
                                    [
                                          "Lahore",
                                          "Karachi",
                                          "Islamabad",
                                          "Multan",
                                          "Faqir Wali",
                                        ]
                                        .map(
                                          (loc) => DropdownMenuItem(
                                            value: loc,
                                            child: Text(loc),
                                          ),
                                        )
                                        .toList(),
                                onChanged: (value) {},
                              ),
                              Slider(
                                min: 50,
                                max: 2000,
                                divisions: 10,
                                label: "Capacity",
                                value: 300,
                                onChanged: (val) {
                                  setState(() {
                                    val = val;
                                  });
                                },
                              ),
                              CustomButton(
                                text: "Apply",
                                height: 40.h,
                                width: 100.h,
                                color: Color(0xFFFF6F61),
                                press: () {
                                  Navigator.pop(context);
                                },
                                border: 25.r,
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.filter_list,
                      color: Color(0xFF000000),
                      size: 25.sp,
                    ),
                    label: Text(
                      "Filter",
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 20.sp,
                      ),
                    ),
                  ),

                  // SizedBox(height: 10.h),
                  // CustomText(
                  //   text: "Recommended Venue",
                  //   color: Color(0xFFFF6F61),
                  //   weight: FontWeight.w500,
                  //   size: 20.sp,
                  // ),
                  // SizedBox(height: 5.h),
                  // CustomCard(
                  //   title: "Sunset Marquee",
                  //   textButton1: "View Detail",
                  //   textButton2: "Book Now",
                  // ),
                  // SizedBox(height: 5.h),
                  //
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     CustomText(
                  //       text: "See all",
                  //       color: Color(0xFF1F1C2C),
                  //       weight: FontWeight.w500,
                  //       size: 20.sp,
                  //     ),
                  //     Icon(Icons.arrow_forward_ios),
                  //   ],
                  // ),
                  SizedBox(height: 5.h),
                  CustomText(
                    text: "My Events",
                    color: Color(0xFFFF6F61),
                    weight: FontWeight.w500,
                    size: 20.sp,
                  ),

                  SizedBox(height: 5.h),
                  CustomCard(
                    title: "Sunset Marquee",
                    textButton1: "View Detail",
                    textButton2: "Cancel",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
