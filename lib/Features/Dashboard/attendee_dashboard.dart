import 'package:event_management_system/CustomWidget/BookedEventsSection.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomCard.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';
import 'package:event_management_system/Features/Profile/profile_view.dart';
import 'package:event_management_system/Features/event/all_events.dart';
import 'package:event_management_system/Features/event/notification_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AttendeeDashboard extends StatefulWidget {
  const AttendeeDashboard({super.key});

  @override
  State<AttendeeDashboard> createState() => _AttendeeDashboardState();
}

class _AttendeeDashboardState extends State<AttendeeDashboard> {
  late List<dynamic> events = [];
  late List<dynamic> bookedEvents = [];
  late List<dynamic> foundEvents;
  @override
  void initState() {
    super.initState();
    foundEvents = events;
    context.read<DashboardBloc>().add(LoadEvents());
  }

  void searchEvents(String keyword) {
    List<dynamic> results = [];

    if (keyword.isEmpty) {
      results = events;
    } else {
      results = events.where((event) {
        final title = event.eventName.toLowerCase();
        final input = keyword.toLowerCase();
        return title.contains(input);
      }).toList();
    }

    setState(() {
      foundEvents = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {},
      builder: (context, state) {
        Widget bodyContent;

        if (state is LoadingState) {
          // Skeleton loader
          bodyContent = ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: true,
                  child: CustomCard(
                    title: "Loading...",
                    street: '.........',
                    town: '.........',
                    url: '...........',
                    city: '.........',
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                    details: [],
                  ),
                ),
              );
            },
          );
        } else if (state is EventLoadedState) {
          events = state.events;
          bookedEvents = state.bookedEvents;
          if (foundEvents.isEmpty) {
            foundEvents = events;
          }

          bodyContent = ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: foundEvents.length ?? 0,
            itemBuilder: (context, index) {
              final event = foundEvents[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: false,
                  child: CustomCard(
                    title: event.eventName ?? "No Title",
                    category: event.category[0],
                    street: event.street,
                    url: event.url[0],
                    town: event.town,
                    city: event.city,
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                    details: [event],
                  ),
                ),
              );
            },
          );
        } else {
          bodyContent = Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Something went wrong",
                  style: TextStyle(
                    color: Colors.redAccent[100],
                    fontSize: 17.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 5.w),
                GestureDetector(
                  onTap: () => context.read<DashboardBloc>().add(LoadEvents()),
                  child: Icon(Icons.refresh, color: Colors.green),
                ),
              ],
            ),
          );
        }
        return WillPopScope(
          onWillPop: () async {
            // Prevent exiting the dashboard (e.g., require confirmation)
            final shouldExit = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: Text('Exit App'),
                content: Text('Do you really want to exit?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    child: Text('No'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, true),
                    child: Text('Yes'),
                  ),
                ],
              ),
            );
            return shouldExit ?? false;
          },

          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: AppBar(
              centerTitle: true,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25.r),
                ),
              ),
              backgroundColor: const Color(0xFFFF6F61),
              title: Text(
                'EventEase',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationView()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: Colors.white,
                      child: Icon(Icons.notifications_none, color: Colors.redAccent),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>ProfileView()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/profile.jpg'),
                    ),
                  ),
                ),
              ],
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
                            onChanged: (value) => searchEvents(value.trim()),
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

                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: const Color(
                                0xFFFF6F61,
                              ).withOpacity(0.2),
                              child: Icon(
                                Icons.recommend,
                                color: const Color(0xFFFF6F61),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              text: "Recommended Venue",
                              color: Color(0xFFFF6F61),
                              weight: FontWeight.w500,
                              size: 20.sp,
                            ),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        bodyContent,
                        SizedBox(height: 5.h),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AllEvents(events: events),
                              ),
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "See all",
                                color: Color(0xFF1F1C2C),
                                weight: FontWeight.w500,
                                size: 20.sp,
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: const Color(
                                0xFFFF6F61,
                              ).withOpacity(0.2),
                              child: Icon(
                                Icons.event,
                                color: const Color(0xFFFF6F61),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              text: "My Booked Events",
                              color: Color(0xFFFF6F61),
                              weight: FontWeight.w500,
                              size: 20.sp,
                            ),
                          ],
                        ),

                        SizedBox(height: 5.h),
                        BookedEventsSection(
                          isLoading: state is LoadingState,
                          bookedEvents: bookedEvents,
                        ),
                        SizedBox(height: 10.h),

                        Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundColor: const Color(
                                0xFFFF6F61,
                              ).withOpacity(0.2),
                              child: Icon(
                                Icons.payments,
                                color: const Color(0xFFFF6F61),
                                size: 20,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            CustomText(
                              text: "Payments",
                              color: Color(0xFFFF6F61),
                              weight: FontWeight.w500,
                              size: 20.sp,
                            ),
                          ],
                        ),
                        Container(
                          height: 170.h,
                          width: 400.w,
                          margin: EdgeInsets.symmetric(vertical: 5.h),
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.r),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                offset: Offset(0, 3),
                                blurRadius: 6,
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Booking Status
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 12.w,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Text(
                                  "Pending", // or "Paid 80%"
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.orange.shade800,
                                  ),
                                ),
                              ),
                              SizedBox(height: 12.h),

                              // Venue Name
                              Text(
                                "Royal Palace Banquet Hall", // dynamic venue name
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                              SizedBox(height: 6.h),

                              // Venue Details
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 18.sp,
                                    color: Colors.redAccent,
                                  ),
                                  SizedBox(width: 6.w),
                                  CustomText(
                                    text: "Edinburgh, Australia",
                                    color: Colors.grey[800]!,
                                    weight: FontWeight.w400,
                                    size: 16.sp,
                                  ),
                                ],
                              ),
                              OutlinedButton.icon(
                                onPressed: () {
                                  // Navigate to customization screen
                                  Navigator.pushNamed(context, "/customize");
                                },
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(
                                    color: Color(0xFFFF6F61),
                                  ),
                                  shape: StadiumBorder(),
                                ),
                                icon: const Icon(
                                  Icons.money,
                                  color: Color(0xFFFF6F61),
                                ),
                                label: Text(
                                  "Pay Now",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: const Color(0xFFFF6F61),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5.w),
                            ],
                          ),
                        ),

                        SizedBox(height: 5.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "See all",
                              color: Color(0xFF1F1C2C),
                              weight: FontWeight.w500,
                              size: 20.sp,
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            // bottomNavigationBar: bottomAppBar(context),
          ),
        );
      },
    );
  }
}
