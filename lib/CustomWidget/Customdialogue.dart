import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class Customdialogue extends StatefulWidget {
  final IconData? icon;
  final String text;

  const Customdialogue({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  State<Customdialogue> createState() => _CustomdialogueState();
}

class _CustomdialogueState extends State<Customdialogue> {
  @override
  Widget build(BuildContext context) {
    return Dialog(

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      backgroundColor: Colors.transparent,
      child: Container(
        height: 250.h,
        width: 300.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: Color(0xFFFAFAF5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 2,
              offset: Offset(2, 0),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0.r),
          child: Column(
            children: [
              SizedBox(height: 15.h),
              Icon(
                widget.icon,
                color: Color(0xffE53935),
                size: 80.sp,
              ),
              SizedBox(height: 20.h),
              Text(
                widget.text,
                style: TextStyle(
                  color: Color(0xffE53935),
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              CustomButton(
                text: "OK",
                height: 30.h,
                width: 100.w,
                color:Color(0xffE53935),
                press: () {
                  Navigator.of(context, rootNavigator: true).pop();
                },
                border: 10.r,
              ),
              SizedBox(
                height: 10.h,
              )
            ],
          ),
        ),
      ),

    );
  }
}

