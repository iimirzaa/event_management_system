import 'package:event_management_system/features/Auth/Auth_Bloc/auth_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_management_system/features/GetStarted/get_started_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return MaterialApp(
          theme: ThemeData(
            fontFamily: 'Roboto'
          ),
            debugShowCheckedModeBanner: false, home: child);
      },
      designSize: Size(411, 731),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetStartedView(),
    );
  }
}
