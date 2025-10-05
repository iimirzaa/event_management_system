import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';

import 'package:event_management_system/Features/event/eventdetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCard extends StatelessWidget {
  final String title;
  final String url;
  final String? street;
  final String ?town;
  final String ?city;
  final String? category;
  final String textButton1;
  final String textButton2;
  final List<dynamic> details;
  const CustomCard({super.key,
    required this.url,
  required this.title,
  required this.textButton1,
  required this.textButton2, this.street,  this.town,this.category,  this.city,required this.details});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
  listener: (context, state) {
    if(state is ViewDetailButtonClickedState){
      print(details);
      Navigator.push(context, MaterialPageRoute(builder: (_)=>EventDetail(event:state.details)));
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
          BoxShadow(color: Colors.black12, offset: Offset(0, 3), blurRadius: 6),
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
            child: CachedNetworkImage(
              imageUrl: url,
              fit: BoxFit.cover,
              width: 400.w,
              height: 200.h, // give fixed height to avoid overflow
              placeholder: (context, url) => Container(
                color: Colors.grey[200],
                height: 200.h,
                child: Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Color(0xFFFF6F61),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[300],
                height: 200.h,
                child: Icon(Icons.broken_image, size: 40, color: Colors.grey[700]),
              ),
            ),
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
                      text: category??'',
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
                      text: "$street, $town,$city",
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
                        context.read<DashboardBloc>().add(ViewDetailButtonClicked(details:details));
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
                      onPressed:(){

                      },
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
