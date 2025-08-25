import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';
import 'package:event_management_system/features/event/eventdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String textButton1;
  final String textButton2;
  const CustomCard({super.key,
  required this.title,
  required this.textButton1,
  required this.textButton2});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
  listener: (context, state) {
    if(state is ViewDetailButtonClickedState){
      Navigator.push(context, MaterialPageRoute(builder: (_)=>EventDetail()));
    }
  },
  builder: (context, state) {
    return Container(
      width: 400.w,
      margin: EdgeInsets.symmetric(vertical: 12.h,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        gradient: LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF7F7F7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(3, 3), blurRadius: 6),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Top Image
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.r),
              topRight: Radius.circular(16.r),
            ),
            child: Image.asset("assets/images/img.png",
            fit: BoxFit.contain,
            width: 400.w,)
          ),

          /// Card Content
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text:title,
                  color: Color(0xFF1F1C2C),
                  weight: FontWeight.w700,
                  size: 20.sp,
                ),
                SizedBox(height: 6.h),

                Row(
                  children: [
                    Icon(Icons.category, size: 18, color: Colors.grey[700]),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: "Birthday Party",
                      color: Colors.grey[800]!,
                      weight: FontWeight.w500,
                      size: 16.sp,
                    ),
                  ],
                ),
                SizedBox(height: 6.h),

                Row(
                  children: [
                    Icon(Icons.location_on, size: 18, color: Colors.redAccent),
                    SizedBox(width: 6.w),
                    CustomText(
                      text: "Edinburgh, Australia",
                      color: Colors.grey[800]!,
                      weight: FontWeight.w400,
                      size: 16.sp,
                    ),
                  ],
                ),
                SizedBox(height: 12.h),

                /// Action Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        context.read<DashboardBloc>().add(ViewDetailButtonClicked());
                      },
                      icon: Icon(Icons.info_outline, color: Color(0xFFFF6F61)),
                      label: Text(
                        textButton1,
                        style: TextStyle(color: Color(0xFFFF6F61)),
                      ),

                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(color: Color(0xFFFF6F61)),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFF6F61),
                        shape: StadiumBorder(),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18.w,
                          vertical: 10.h,
                        ),
                      ),
                      child: Text(
                        textButton2,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  },
);
  }
}
