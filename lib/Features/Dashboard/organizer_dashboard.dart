import 'package:event_management_system/CustomWidget/BottomNavigationBar.dart';
import 'package:event_management_system/features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';
import 'package:event_management_system/features/event/createevent_presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../Services/token_storage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrganizerDashboard extends StatefulWidget {
  const OrganizerDashboard({super.key});

  @override
  State<OrganizerDashboard> createState() => _OrganizerDashboardState();
}

class _OrganizerDashboardState extends State<OrganizerDashboard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) {
        if(state is CreateEventButtonState){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>CreateEventView()));
        }

      },
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
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
                      "Welcome back❤️",
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
                child: Center(child: Column(children: [])),
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
