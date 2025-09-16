import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomCard.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Features/event/event_bloc/event_bloc.dart';
import 'package:event_management_system/Services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AllEvents extends StatefulWidget {
  const AllEvents({super.key});

  @override
  State<AllEvents> createState() => _AllEvents();
}

class _AllEvents extends State<AllEvents> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return PopScope(
          canPop: false,
          onPopInvoked: (didPop) {
            if (!didPop) {
              // Close the app when back is pressed
              Navigator.of(context).maybePop();
            }
          },
          child: Scaffold(
            appBar: AppBar(
              iconTheme: IconThemeData(
                  color: Colors.white
              ),
              centerTitle: true,
              backgroundColor: Colors.blueGrey,
              title: FutureBuilder<String?>(
                future: TokenStorage.getName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text(
                      "Welcome ...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text(
                      "Error",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return Text(
                      "Welcome ${snapshot.data}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF1f1c2c),
                      Color(0xFF928dab),
                    ],
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
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: const Color(0xFFFF6F61)
                                  .withOpacity(0.2),
                              child: Icon(Icons.recommend,
                                  color: const Color(0xFFFF6F61), size: 20),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            CustomText(
                              text: "Recommended Venue",
                              color: Color(0xFFFF6F61),
                              weight: FontWeight.w500,
                              size: 20.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Skeletonizer(
                          enabled: true,
                          child: CustomCard(
                            title: "Sunset Marquee",
                            textButton1: "View Detail",
                            textButton2: "Book Now",
                          ),
                        ),
                        SizedBox(height: 5.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
