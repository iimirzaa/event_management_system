import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:event_management_system/features/GetStarted/get_started_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
