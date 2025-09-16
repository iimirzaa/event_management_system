import 'package:event_management_system/features/Auth/Auth_Bloc/auth_bloc.dart';
import 'package:event_management_system/features/Dashboard/Dashboard_bloc/dashboard_bloc.dart';
import 'package:event_management_system/features/Dashboard/attendee_dashboard.dart';
import 'package:event_management_system/features/Dashboard/organizer_dashboard.dart';
import 'package:event_management_system/features/event/event_bloc/event_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_management_system/features/GetStarted/get_started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../services/token_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Widget> _getInitialScreen() async {
    Map<String, dynamic>? token = await TokenStorage.getDecodedToken();
    if (token == null) {
      return const GetStartedView();
    } else {
      if (token['role'] == 'Attendee') {
        return const AttendeeDashboard();
      } else if (token['role'] == 'Organizer') {
        return const OrganizerDashboard();
      } else {
        return const GetStartedView();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(create: (_) => AuthBloc()),
            BlocProvider<DashboardBloc>(create: (_) => DashboardBloc()),
            BlocProvider<EventBloc>(create: (_) => EventBloc()),
          ],
          child: MaterialApp(
            theme: ThemeData(fontFamily: 'Roboto'),
            debugShowCheckedModeBanner: false,
            home: FutureBuilder<Widget>(
              future: _getInitialScreen(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    color: Colors.white.withOpacity(0.3),
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0xFFFF6F61),
                        size: 80,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return const Scaffold(
                    body: Center(child: Text("Error loading app")),
                  );
                } else {
                  return snapshot.data!;
                }
              },
            ),
          ),
        );
      },
    );
  }
}
