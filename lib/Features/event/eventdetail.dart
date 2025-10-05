import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';

class EventDetail extends StatefulWidget {
  final List<dynamic> event;
  const EventDetail({super.key,required this.event});


  @override
  State<EventDetail> createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.blueGrey
        ),
           title: Text("${widget.event[0].eventName}",
           style:  TextStyle(// Title
             color: const Color(0xFFFF6F61),
             fontWeight: FontWeight.w600,
             fontSize: 32.sp,
           ),),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                SizedBox(height: 8.h),

                // 🔹 Image Carousel with Buttons
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: CarouselSlider(
                        items:widget.event[0].url.map<Widget>(
                              (img) => CachedNetworkImage(
                                imageUrl: img,
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
                        ).toList(),

                        options: CarouselOptions(
                          height: 300.h,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 5),
                        ),
                      ),
                    ),

                    // Buttons (prev/next/fullscreen)
                    Positioned(
                      left: 8,
                      top: 120.h,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.arrow_back_ios_new,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 8,
                      top: 120.h,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: 18,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black54,
                        child: Icon(
                          Icons.fullscreen,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 20.h),

                //  Categories
                _buildSectionCard(
                  icon: Icons.category,
                  title: "Categories",
                  child: Wrap(
                    spacing: 8,
                    children: [
                    ...widget.event[0].category.map((c)=>_buildChip(c)).toList(),
                    ],
                  ),
                ),

                SizedBox(height: 16.h),

                // Capacity
                _buildSectionCard(
                  icon: Icons.people,
                  title: "Capacity",
                  child: Text(
                    "${widget.event[0].capacity} Guests",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                  ),
                ),

                SizedBox(height: 16.h),

                //  Location
                _buildSectionCard(
                  icon: Icons.location_on,
                  title: "Location",
                  child: Text(
                    "${widget.event[0].street},${widget.event[0].town},${widget.event[0].city}",
                    style: TextStyle(fontSize: 16.sp, color: Colors.black87),
                  ),
                ),

                SizedBox(height: 16.h),

                //  Services
                _buildSectionCard(
                  icon: Icons.room_service,
                  title: "Services Available",
                  child: Wrap(
                    spacing: 8,
                    children: [
                      ...widget.event[0].service.map((c)=>_buildChip(c)).toList(),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // 🔹 Action Buttons (Book / Customize)
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to booking screen
                          Navigator.pushNamed(context, "/booking");
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFF6F61),
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: const Icon(Icons.event_available, color: Colors.white),
                        label: Text(
                          "Book Venue",
                          style: TextStyle(fontSize: 16.sp, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          // Navigate to customization screen
                          Navigator.pushNamed(context, "/customize");
                        },
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          side: const BorderSide(color: Color(0xFFFF6F61)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: const Icon(Icons.build, color: Color(0xFFFF6F61)),
                        label: Text(
                          "Customize",
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xFFFF6F61),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Section Card Widget
  Widget _buildSectionCard({
    required IconData icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      padding: EdgeInsets.all(14.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundColor: const Color(0xFFFF6F61).withOpacity(0.1),
                child: Icon(icon, color: const Color(0xFFFF6F61), size: 18),
              ),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          child,
        ],
      ),
    );
  }

  // 🔹 Custom Chip Style
  Widget _buildChip(String label) {
    return Chip(
      label: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: const Color(0xFFFF6F61),
        ),
      ),
      backgroundColor: const Color(0xFFFF6F61).withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
        side: BorderSide(color: const Color(0xFFFF6F61)),
      ),
    );
  }
}
