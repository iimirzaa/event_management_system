import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:event_management_system/features/Auth/Login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GetStartedView extends StatefulWidget {
  const GetStartedView({super.key});

  @override
  State<GetStartedView> createState() => _GetStartedViewState();
}

class _GetStartedViewState extends State<GetStartedView> {
  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: "Event",
                        color: Color(0xFFFF6F61),
                        weight: FontWeight.w800,
                        size: 30.sp,
                      ),
                      CustomText(
                        text: "Ease",
                        color: Colors.white,
                        size: 30.sp,
                        weight: FontWeight.w800,
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    text: "Plan.Book.Celebrate.",
                    color: Colors.white54,
                    weight: FontWeight.w500,
                    size: 20.sp,
                  ),
                  SizedBox(height: 250.h),
                  CustomButton(
                    text: "GET STARTED",
                    height: 50.h,
                    width: 200.w,
                    color: Color(0xFFFF6F61),
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => LoginView()),
                      );
                    },
                  ),
                  SizedBox(height: 100.h),
                  CustomText(
                    text: '\u00A9 EventEase 2025 inc.',
                    size: 16.sp,
                    color: Colors.white54,
                    weight: FontWeight.w600,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
