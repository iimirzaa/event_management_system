import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_management_system/CustomWidget/Customdialogue.dart';
import 'package:event_management_system/Features/event/event_bloc/event_bloc.dart';
import 'package:event_management_system/Services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class EventUpdateView extends StatefulWidget {
  final List<dynamic> event;
  const EventUpdateView({super.key, required this.event});

  @override
  State<EventUpdateView> createState() => _EventUpdateState();
}

class _EventUpdateState extends State<EventUpdateView> {
  List<String> selectedCategory = [];
  List<String> selectedService = [];
  final TextEditingController _capacityController = TextEditingController();

  final TextEditingController _detailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        if (state is MessageState) {
          showDialog(
            context: context,
            builder: (_) => Customdialogue(
              icon: state.icon,
              text: state.errorMessage ?? '',
            ),
          );
        }
        if (state is EventSuccessfulState) {
          showDialog(
            context: context,
            builder: (_) => Customdialogue(
              icon: Icons.check_circle,
              text: "Event booked Successfully",
              color: Colors.green,
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(25.r),
                  ),
                ),
                backgroundColor: const Color(0xFFFF6F61),
                automaticallyImplyLeading: true,

                iconTheme: IconThemeData(color: Colors.white),
                title: Text(
                  "${widget.event[0].eventName}",
                  style: TextStyle(
                    // Title
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 32.sp,
                  ),
                ),
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
                                items: widget.event[0].url
                                    .map<Widget>(
                                      (img) => CachedNetworkImage(
                                        imageUrl: img,
                                        fit: BoxFit.cover,
                                        width: 400.w,
                                        height: 200
                                            .h, // give fixed height to avoid overflow
                                        placeholder: (context, url) =>
                                            Container(
                                              color: Colors.grey[200],
                                              height: 200.h,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                      strokeWidth: 2,
                                                      color: Color(0xFFFF6F61),
                                                    ),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Container(
                                              color: Colors.grey[300],
                                              height: 200.h,
                                              child: Icon(
                                                Icons.broken_image,
                                                size: 40,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                      ),
                                    )
                                    .toList(),

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
                        _buildSectionCard(
                          icon: Icons.location_on,
                          title: "Location",
                          child: Text(
                            "${widget.event[0].street},${widget.event[0].town},${widget.event[0].city}",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ),

                        SizedBox(height: 16.h),

                        //  Categories
                        _buildSectionCard(
                          icon: Icons.category,
                          title: "Category",
                          child: Wrap(
                            spacing: 8,
                            children: [
                              ...widget.event[0].category.map((category) {
                                final isSelected = selectedCategory.contains(
                                  category,
                                );

                                return _buildChip(
                                  isSelected,
                                  category,
                                  selectedCategory,
                                );
                              }).toList(),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        // Capacity
                        _buildSectionCard(
                          icon: Icons.people,
                          title: "Capacity",
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Maximum Capacity:",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "${widget.event[0].capacity} Guests",
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),

                        SizedBox(height: 16.h),

                        //  Services
                        _buildSectionCard(
                          icon: Icons.room_service,
                          title: "Services",
                          child: Wrap(
                            spacing: 8,
                            children: [
                              ...widget.event[0].service.map((service) {
                                final isSelected = selectedService.contains(
                                  service,
                                );

                                return _buildChip(
                                  isSelected,
                                  service,
                                  selectedService,
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                        SizedBox(height: 16.h),

                        OutlinedButton.icon(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(

                            backgroundColor: Colors.deepOrange.shade100,
                            minimumSize: Size(400.w, 40.h),
                            padding: EdgeInsets.symmetric(vertical: 14.h),
                            side: const BorderSide(color: Color(0xFFFF6F61)),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ),
                          icon: const Icon(
                            Icons.update,
                            color: Color(0xFFFF6F61),
                          ),
                          label: Text(
                            "Update",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: const Color(0xFFFF6F61),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is LoadingState)
              Container(
                color: Colors.black.withOpacity(
                  0.3,
                ), // semi-transparent background
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Color(0xFFFF6F61),
                    size: 80,
                  ),
                ),
              ),
          ],
        );
      },
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
  Widget _buildChip(bool isSelected, String category, List<String> list) {
    return Chip(
      side: BorderSide(color: Color(0xFFFF6F61)),
      label: Text(category),
    );
  }
}
