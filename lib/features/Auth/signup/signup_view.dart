import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:event_management_system/features/Auth/Login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Auth_Bloc/auth_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _role_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _password_controller = TextEditingController();
  bool notvisiblesignup = true;
  final _form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is EyeIconSignUpState) {
          setState(() {
            notvisiblesignup = state.visibilty;
          });
        }
        if (state is SignUpState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SignupView()),
          );
        }
        if (state is LoginGestureState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginView()),
          );
        }
      },
      builder: (context, state) {
        return GradientScaffold(
          body: SingleChildScrollView(
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100.h),
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
                          padding: EdgeInsets.all(16.0.r),
                          child: Form(
                            key: _form_key,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,

                              children: [
                                SizedBox(height: 10.h),
                                CustomText(
                                  text: "EventEase",
                                  color: Color(0xFFFF6F61),
                                  weight: FontWeight.w800,
                                  size: 40.sp,
                                ),
                                SizedBox(height: 20.h),
                                CustomText(
                                  text: "Select your role",
                                  color: Colors.white,
                                  weight: FontWeight.w600,
                                  size: 22.sp,
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    CustomButton(
                                      text: "Organizer",
                                      height: 40.h,
                                      width: 150.w,
                                      color:
                                          state is RoleButtonState &&
                                              state.role == "Organizer"
                                          ? Color(0xFFFF6F61)
                                          : Colors.transparent,
                                      border: 30,
                                      press: () {
                                        context.read<AuthBloc>().add(
                                          RoleButtonClicked(role: "Organizer"),
                                        );
                                      },
                                    ),
                                    SizedBox(width: 10.w),
                                    CustomButton(
                                      text: "Attendee",
                                      height: 40.h,
                                      width: 150.w,
                                      color:
                                          state is RoleButtonState &&
                                              state.role == "Attendee"
                                          ? Color(0xFFFF6F61)
                                          : Colors.transparent,
                                      border: 30,
                                      press: () {
                                        context.read<AuthBloc>().add(
                                          RoleButtonClicked(role: "Attendee"),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                                SizedBox(height: 15.h),
                                CustomInput(hint: "Enter your full name"),
                                SizedBox(height: 15.h),
                                CustomInput(hint: "Enter your email"),
                                SizedBox(height: 15.h),
                                CustomInput(
                                  hint: "Enter your password",
                                  icon: notvisiblesignup
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  obsecure: notvisiblesignup,
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      EyeIconClicked(
                                        visibilty: notvisiblesignup,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 15.h),
                                CustomInput(
                                  hint: "Confirm your password",
                                  icon: notvisiblesignup
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  obsecure: notvisiblesignup,
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      EyeIconClicked(
                                        visibilty: notvisiblesignup,
                                      ),
                                    );
                                  },
                                ),
                                SizedBox(height: 15.h),
                                CustomButton(
                                  text: "Sign Up",
                                  height: 40.h,
                                  width: 320.w,
                                  color: Color(0xFFFF6F61),
                                  border: 12,
                                  press: () {},
                                ),

                                SizedBox(height: 10.h),
                                GestureDetector(
                                  onTap: () {
                                    context.read<AuthBloc>().add(
                                      LoginGestureClicked(),
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Already have account?",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "Login",
                                        style: TextStyle(
                                          color: Color(0xFFFF6F61),
                                          fontSize: 20.sp,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
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
        );
      },
    );
  }
}
