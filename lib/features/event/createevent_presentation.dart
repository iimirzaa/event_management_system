import 'dart:io';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class CreateEventView extends StatefulWidget {
  const CreateEventView({super.key});

  @override
  State<CreateEventView> createState() => _CreateEventViewState();
}

class _CreateEventViewState extends State<CreateEventView> {
  // Controllers
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _capacityController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final ImagePicker picker = ImagePicker();

  // Dropdown values
  final List<String> categories = [
    "Conference",
    "Wedding",
    "Birthday",
    "Concert",
    "Corporate",
  ];
  List<String> selectedCategories = [];

  // Services Offered
  final List<String> services = [
    "Catering",
    "Photography",
    "Music",
    "Decoration",
  ];
  List<String> selectedServices = [];
  List<XFile> selectedImage = [];
  Future<void> pickImages() async {
    final List<XFile> images = await picker.pickMultiImage(
      imageQuality: 85, // Compress images
    );

    if (images.isNotEmpty) {
      setState(() {
        selectedImage.addAll(images);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          text: "Create New Event",
          color: Colors.white,
          weight: FontWeight.w600,
          size: 25.sp,
        ),
        backgroundColor: Colors.blueGrey,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
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
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Event Name
                _buildInputCard(
                  icon: Icons.event,
                  title: "Event Name",
                  hinttext: "Enter event name",
                  context: context,
                ),

                SizedBox(height: 8.h),
                _buildSectionCard(
                  icon: Icons.category,
                  title: "Category",
                  child: Wrap(
                    spacing: 8.w,
                    children: categories.map((categories) {
                      final isSelected = selectedCategories.contains(
                        categories,
                      );
                      return FilterChip(
                        side: BorderSide(color: Color(0xFFFF6F61)),
                        label: Text(categories),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedCategories.add(categories);
                            } else {
                              selectedCategories.remove(categories);
                            }
                          });
                        },
                        selectedColor: Colors.redAccent.shade100,
                        checkmarkColor: Colors.green,
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 16.h),
                _buildSectionCard(
                  icon: Icons.image,
                  title: "Event Images",
                  child: Column(
                    children: [
                      OutlinedButton.icon(
                        onPressed: pickImages,
                        label: Text(
                          "Add Images",
                          style: TextStyle(color: Color(0xFFFF6F61)),
                        ),
                        icon: Icon(
                          Icons.add_photo_alternate_outlined,
                          color: Color(0xFFFF6F61),
                        ),
                        style: OutlinedButton.styleFrom(
                          maximumSize: Size(150.w, 40.h),
                          side: BorderSide(color: Color(0xFFFF6F61)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: selectedImage.map((images) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: Image.file(
                              File(images.path),
                              width: 100.w,
                              height: 100.w,
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16.h),

                // Capacity
                _buildInputCard(
                  icon: Icons.group,
                  title: "Capacity",
                  hinttext: "Enter Capacity",
                  context: context,
                ),
                SizedBox(height: 16.h),
                _buildSectionCard(
                  icon: Icons.location_on,
                  title: "Location",
                  child: Column(
                    children: [
                      TextFormField(
                        cursorColor: Color(0xFFFF6F61),
                        onTapOutside: (event) {
                          Focus.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Street No#",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14.sp,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 14.w,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF6F61),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      TextFormField(
                        cursorColor: Color(0xFFFF6F61),
                        onTapOutside: (event) {
                          Focus.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "Town...",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14.sp,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 14.w,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF6F61),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 6.h),
                      TextFormField(
                        cursorColor: Color(0xFFFF6F61),
                        onTapOutside: (event) {
                          Focus.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: "City*",
                          hintStyle: TextStyle(
                            color: Colors.grey.shade800,
                            fontSize: 14.sp,
                          ),

                          contentPadding: EdgeInsets.symmetric(
                            vertical: 14.h,
                            horizontal: 14.w,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(
                              color: Color(0xFFFF6F61),
                              width: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // // Location
                // _buildInputCard(
                //   icon: Icons.location_on,
                //   title: "Location",
                //   hinttext: "Enter event Location",
                //   context: context,
                // ),
                SizedBox(height: 16.h),

                // Services Offered
                SizedBox(height: 8.h),
                _buildSectionCard(
                  icon: Icons.local_restaurant_sharp,
                  title: "Services Offered",
                  child: Wrap(
                    spacing: 8.w,
                    children: services.map((service) {
                      final isSelected = selectedServices.contains(service);
                      return FilterChip(
                        side: BorderSide(color: Color(0xFFFF6F61)),
                        label: Text(service),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            if (selected) {
                              selectedServices.add(service);
                            } else {
                              selectedServices.remove(service);
                            }
                          });
                        },
                        selectedColor: Colors.redAccent.shade100,
                        checkmarkColor: Colors.green,
                      );
                    }).toList(),
                  ),
                ),

                SizedBox(height: 30.h),

                // Submit Button
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Handle create event logic here
                      print("Event Created!");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFF6F61),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    icon: Icon(Icons.create, color: Colors.white, size: 20.sp),
                    label: Text(
                      "Create Event",
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

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

Widget _buildInputCard({
  required IconData icon,
  required String title,
  required String hinttext,
  required BuildContext context,
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
              backgroundColor: Color(0xFFFF6F61).withOpacity(0.1),
              child: Icon(icon, color: Color(0xFFFF6F61), size: 18.sp),
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
        TextFormField(
          cursorColor: Color(0xFFFF6F61),
          onTapOutside: (event) {
            Focus.of(context).unfocus();
          },
          decoration: InputDecoration(
            constraints: BoxConstraints(maxHeight: 40.h, minHeight: 40.h),
            hintText: hinttext,
            hintStyle: TextStyle(color: Colors.grey.shade800, fontSize: 14.sp),

            contentPadding: EdgeInsets.symmetric(
              vertical: 14.h,
              horizontal: 14.w,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: Color(0xFFFF6F61), width: 2),
            ),
          ),
        ),
      ],
    ),
  );
}
