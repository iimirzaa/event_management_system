import 'package:event_management_system/CustomWidget/Customdialogue.dart';
import 'package:event_management_system/Features/Auth/Auth_Bloc/auth_bloc.dart';
import 'package:event_management_system/Features/Auth/Login/login_view.dart';
import 'package:event_management_system/Features/Profile/profile_view.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ChangePasswordView extends StatefulWidget {
  final String previous;
  final String email;
  const ChangePasswordView({super.key,required this.previous,required this.email});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordView();
}

class _ChangePasswordView extends State<ChangePasswordView> {
  final _formkey = GlobalKey<FormState>();
  bool visibility = true;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async{
        print(widget.previous);
        if (state is ForgetPasswordState && widget.previous=='home') {
          await  showDialog(
          context: context,
          builder: (_) => Customdialogue(
            icon: Icons.check_circle,
            text: " Password Changed Successfully!",
            color: Colors.green,
          ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => ProfileView()),
          );
        }else if(state is ForgetPasswordState && widget.previous=='forgetpassword'){
          await  showDialog(
            context: context,
            builder: (_) => Customdialogue(
              icon: Icons.check_circle,
              text: " Password Changed Successfully!",
              color: Colors.green,
            ),
          );
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> BlocProvider(create: (_)=>AuthBloc(),child: LoginView(),)));

        }
        if (state is EyeIconSignUpState) {
          setState(() {
            visibility = state.visibilty;
          });
        }
      },
      builder: (context, state) {
        return Stack(
          children: [
            GradientScaffold(
              body: SafeArea(
                child: SingleChildScrollView(
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
                                key: _formkey,
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
                                    CustomInput(
                                      hint: "Enter new Password",
                                      controller: _passwordController,
                                      icon: visibility
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      obsecure: visibility,
                                      onTap: () => context.read<AuthBloc>().add(
                                        EyeIconSignUpClicked(
                                          visibilty: visibility,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                    CustomInput(
                                      hint: "Confirm Password",
                                      controller: _confirmPassword,
                                      icon: visibility
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      obsecure: visibility,
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          EyeIconSignUpClicked(
                                            visibilty: visibility,
                                          ),
                                        );
                                      },
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
                                      text: "Change Password",
                                      height: 40.h,
                                      width: 320.w,
                                      color: Color(0xFFFF6F61),
                                      press: () {
                                        context.read<AuthBloc>().add(
                                          ChangePasswordClickedEvent(
                                            key: _formkey.currentState!
                                                .validate(),
                                            email: widget.email,
                                            password: _passwordController.text,
                                            cofirmpassword: _confirmPassword.text
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
