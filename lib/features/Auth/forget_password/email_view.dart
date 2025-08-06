import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:event_management_system/features/Auth/forget_password/email_view.dart';
import 'package:event_management_system/features/Auth/signup/signup_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Auth_Bloc/auth_bloc.dart';


class EmailView extends StatefulWidget {
  const EmailView({super.key});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return GradientScaffold(
          body: SafeArea(
            child: Center(child: Padding(
              padding: EdgeInsets.all(40.r),
              child: Column(

                  children: [
                SizedBox(height: 150.h),
                CustomText(
                  text: "EventEase",
                  color: Color(0xFFFF6F61),
                  weight: FontWeight.w800,
                  size: 40.sp,
                ),
                SizedBox(
                  height: 10.h,
                ),
                  CustomText(
                    text: "Please enter your email address to get your OTP.",
                    color: Colors.white54,
                    size: 20.sp,
                    weight: FontWeight.w600,
                  ),
                    SizedBox(
                      height: 10.h,
                    ),
                    if(state is ErrorState)...[
                      CustomText(text: state.errorMsg??'', color: Colors.redAccent, weight: FontWeight.w400)

                    ],
                    CustomInput(hint: "Enter your Email"),
                    SizedBox(
                      height: 10.h,
                    ),

                    CustomButton(text: "Send OTP", height: 40.h, width: 320.w, color: Color(0xFFFF6F61), press: (){}, border: 12.r)


              ]),
            )),
          ),
        );
      },
    );
  }
}
