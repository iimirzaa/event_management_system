import 'package:event_management_system/Features/Auth/Otp/verify_otp_presentation.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:event_management_system/Services/token_storage.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Auth_Bloc/auth_bloc.dart';

class SendOtpView extends StatefulWidget {
  final String previous;
  const SendOtpView({super.key, required this.previous});

  @override
  State<SendOtpView> createState() => _SendOtpViewState();
}

class _SendOtpViewState extends State<SendOtpView> {
  late Future<String> _emailFuture;

  @override
  void initState() {
    super.initState();
    _emailFuture = TokenStorage.getEmail().then((value) => value ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _emailFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final email = snapshot.data!;

        return BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SendOtpSuccessfulState) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider(create: (_)=>AuthBloc(),child:VerifyOtp(
                    email: email,
                    previous: widget.previous, // <-- use the passed flag
                  ),)
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
                                color: const Color(0xFF928dab),
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(2, 0),
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.all(20.0.r),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      text: "EventEase",
                                      color: const Color(0xFFFF6F61),
                                      weight: FontWeight.w800,
                                      size: 40.sp,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomText(
                                      text:
                                          "Please press on Send OTP to receive a 4-digit OTP at your email: $email",
                                      color: Colors.white,
                                      size: 20.sp,
                                      weight: FontWeight.w600,
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomButton(
                                      text: "Send OTP",
                                      height: 40.h,
                                      width: 320.w,
                                      color: const Color(0xFFFF6F61),
                                      press: () {
                                        context.read<AuthBloc>().add(
                                          SendOtpClicked(
                                              key:true,email: email),
                                        );
                                      },
                                      border: 12.r,
                                    ),
                                  ],
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
                    color: Colors.black.withOpacity(0.3),
                    child: Center(
                      child: LoadingAnimationWidget.staggeredDotsWave(
                        color: const Color(0xFFFF6F61),
                        size: 80,
                      ),
                    ),
                  ),
              ],
            );
          },
        );
      },
    );
  }
}
