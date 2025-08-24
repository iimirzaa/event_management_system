import 'package:event_management_system/features/Auth/Auth_Bloc/auth_bloc.dart';
import 'package:event_management_system/features/Dashboard/attendee_dashboard.dart';
import 'package:event_management_system/features/Dashboard/organizer_dashboard.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_management_system/features/GetStarted/get_started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/token_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );

}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget>? _getInitialScreen() async {
    Map<String, dynamic>? token = await TokenStorage.getDecodedToken();

    if (token == null) {
      return const GetStartedView(); // not logged in
    } else {
      if (token['role'] == 'Attendee') {
        return const AttendeeDashboard();
      } else if (token['role'] == 'Organizer') {
        return const OrganizerDashboard();
      } else {
        return const GetStartedView(); // fallback
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit (
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto'
          ),
            debugShowCheckedModeBanner: false, home: FutureBuilder(future: _getInitialScreen(), builder: (context,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return Container(
                  color: Colors.black.withOpacity(
                    0.3,
                  ), // semi-transparent background
                  child: Center(
                    child: LoadingAnimationWidget.staggeredDotsWave(
                      color: Color(0xFFFF6F61),
                      size: 80,
                    ),
                  ),
                );
              }else if (snapshot.hasError) {
                return const Scaffold(
                  body: Center(child: Text("Error loading app")),
                );
              } else {
                return snapshot.data!;
              }


        }));
      },
      designSize: Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: true,

    );
  }
}
