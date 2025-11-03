import 'package:event_management_system/Features/Auth/Auth_Bloc/auth_bloc.dart';
import 'package:event_management_system/Features/Auth/Otp/verify_otp_presentation.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


class EmailView extends StatefulWidget {
  final String previous;
  const EmailView({super.key, required this.previous});

  @override
  State<EmailView> createState() => _EmailViewState();
}

class _EmailViewState extends State<EmailView> {
  final _form_key = GlobalKey<FormState>();
  final TextEditingController _emailcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is SendOtpSuccessfulState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider(
                create: (context) => AuthBloc(),
                child: VerifyOtp(
                  email: _emailcontroller.text.trim(),
                  previous: 'forgetpassword',
                ),
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GradientScaffold(
              body: SafeArea(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(20.r),
                    child: Column(
                      children: [
                        SizedBox(height: 150.h),
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFF928dab),
                            backgroundBlendMode: BlendMode.softLight,
                            borderRadius: BorderRadius.circular(16.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 2,
                                offset: Offset(2, 0),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(20.0.r),
                            child: Form(
                              key: _form_key,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CustomText(
                                    text: "EventEase",
                                    color: Color(0xFFFF6F61),
                                    weight: FontWeight.w800,
                                    size: 40.sp,
                                  ),
                                  SizedBox(height: 10.h),
                                  CustomText(
                                    text:
                                        "Please enter your email address to get your OTP.",
                                    color: Colors.white54,
                                    size: 20.sp,
                                    weight: FontWeight.w600,
                                  ),

                                  SizedBox(height: 10.h),

                                  CustomInput(
                                    hint: "Enter your Email",
                                    controller: _emailcontroller,
                                  ),
                                  SizedBox(height: 10.h),
                                  if (state is ErrorState) ...[
                                    CustomText(
                                      text: state.errorMsg ?? '',
                                      color: Colors.redAccent,
                                      weight: FontWeight.w400,
                                    ),
                                  ],
                                  SizedBox(height: 5.h),

                                  CustomButton(
                                    text: "Send OTP",
                                    height: 40.h,
                                    width: 320.w,
                                    color: Color(0xFFFF6F61),
                                    press: () {
                                      context.read<AuthBloc>().add(
                                        SendOtpClicked(
                                          key: _form_key.currentState!
                                              .validate(),
                                          email: _emailcontroller.text,
                                        ),
                                      );
                                    },
                                    border: 12.r,
                                  ),
                                  SizedBox(height: 15.h),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (state is LoadingState)
              Container(
                color: Colors.black.withOpacity(
                  0.3,
                ), // semi-transparent background
                child: Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Color(0xFFFF6F61),
                    size: 80,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
