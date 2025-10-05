import 'package:event_management_system/CustomWidget/BottomNavigationBar.dart';
import 'package:event_management_system/CustomWidget/CustomCard.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';
import 'package:event_management_system/Features/event/createevent_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../Services/token_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerDashboard extends StatefulWidget {
  const OrganizerDashboard({super.key});

  @override
  State<OrganizerDashboard> createState() => _OrganizerDashboardState();
}

class _OrganizerDashboardState extends State<OrganizerDashboard> {
  late List<dynamic> events;
  @override @override
  void initState() {
   super.initState();
   context.read<DashboardBloc>().add(LoadOrganizerEvents());
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if(state is CreateEventButtonState){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateEventView()));
        }

      },
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
                    city:'.........',
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                    details: [],
                  ),
                ),
              );
            },
          );
        } else if (state is OrganizerEventLoadedState) {
          events = state.events;

          bodyContent = ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: false,
                  child: CustomCard(
                    title:event.eventName ?? "No Title",
                    category: event.category[0],
                    street: event.street,
                    url: event.url[0],
                    town: event.town,
                    city:event.city,
                    textButton1: "View Detail",
                    textButton2: "Update",
                    details: [event],
                  ),
                ),
              );
            },
          );
        } else {
          bodyContent =  Center(child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Something went wrong",style: TextStyle(
                  color: Colors.redAccent[100],
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500
              ),),
              SizedBox(
                width: 5.w,
              ),
              GestureDetector(
                onTap: ()=>context.read<DashboardBloc>().add(LoadOrganizerEvents()),
                child: Icon(Icons.refresh,
                  color: Colors.green,),
              )
            ],
          ));
        }
        return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: true,
              shape:  RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(25.r)),
              ),

              centerTitle: true,
              backgroundColor: Colors.blueGrey,
              title: FutureBuilder<String?>(
                future: TokenStorage.getName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      "Welcome ...",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      "Error",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return Text(
                      // "Welcome ${snapshot.data}",
                      "Welcome ${snapshot.data}",
                      style: TextStyle(
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
                  child: Center(child: Column(children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: const Color(0xFFFF6F61).withOpacity(0.2),
                          child: Icon(Icons.event_note_outlined, color: const Color(0xFFFF6F61), size: 20),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        CustomText(
                          text: "My Events",
                          color: Color(0xFFFF6F61),
                          weight: FontWeight.w500,
                          size: 20.sp,
                        ),
                      ],
                    ),
                    bodyContent
                  ])),
                ),
              ),
            ),
            floatingActionButton: FloatingActionButton(onPressed: () {
              context.read<DashboardBloc>().add(CreateEventButtonClicked());
            },
              splashColor: Color(0xff918989),

              shape: CircleBorder(),
              tooltip: "Create new event",
              backgroundColor: Color(0xFFFF6F61),
              child: Icon(Icons.add, color: Colors.white,
                size: 35.sp,
                opticalSize: 30,),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation
                .centerDocked,
            bottomNavigationBar: bottomAppBar()
        );
      },
    );
  }
}
