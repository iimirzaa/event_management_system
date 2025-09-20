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
  void initState() {
    super.initState();
    context.read<EventBloc>().add(LoadEvents());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventBloc, EventState>(
      listener: (context, state) {
        // you can add snackbar or navigation here if needed
      },
      builder: (context, state) {
        Widget bodyContent;

        if (state is LoadingState) {
          // Skeleton loader
          bodyContent = ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: true,
                  child: CustomCard(
                    title: "Loading...",
                    street: '.........',
                    town: '.........',
                    city:'.........',
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                  ),
                ),
              );
            },
          );
        } else if (state is EventLoadedState) {
          final events = state.events;

          bodyContent = ListView.builder(
            shrinkWrap: true,

            itemCount: events.length,
            itemBuilder: (context, index) {
              final event = events[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: Skeletonizer(
                  enabled: false,
                  child: CustomCard(
                    title:event.eventName ?? "No Title",
                    street: event.street,
                    town: event.town,
                    city:event.city,
                    textButton1: "View Detail",
                    textButton2: "Book Now",
                  ),
                ),
              );
            },
          );
        } else {
          bodyContent = const Center(child: Text("Something went wrong"));
        }

        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.white),
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
              child: bodyContent,
            ),
          ),
        );
      },
    );
  }
}
