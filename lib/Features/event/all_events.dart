import 'package:event_management_system/CustomWidget/CustomCard.dart';
import 'package:event_management_system/Services/event_model.dart';
import 'package:event_management_system/Services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';


class AllEvents extends StatelessWidget {
  final List<dynamic> events; // already loaded from dashboard

  const AllEvents({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Colors.blueGrey,
        title: FutureBuilder<String?>(
          future: TokenStorage.getName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Welcome ...",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
            } else if (snapshot.hasError) {
              return const Text("Error",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
            } else {
              return Text("Welcome ${snapshot.data}",
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold));
            }
          },
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1f1c2c), Color(0xFF928dab)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.r),
          child: events.isEmpty
              ? const Center(child: Text("No events found"))
              : ListView.builder(
            shrinkWrap: true,
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: false, // ⚡ no shimmer, just wraps your widget
                  child: CustomCard(
                    title: event.eventName ?? "No Title",
                    street: event.street,
                    category: event.category[0],
                    town: event.town,
                    city: event.city,
                    url: event.url[index],
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                    details: [],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
