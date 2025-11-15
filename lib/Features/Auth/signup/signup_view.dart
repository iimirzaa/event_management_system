import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/Customdialogue.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:event_management_system/Features/Auth/Otp/verify_otp_presentation.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:event_management_system/Features/Auth/Login/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:event_management_system/Features/Auth/Auth_Bloc/auth_bloc.dart';

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final _role_controller = TextEditingController();
  final _email_controller = TextEditingController();
  final _password_controller = TextEditingController();

  final _username_controller = TextEditingController();

  final _confirm_controller = TextEditingController();
  bool notvisiblesignup = true;
  final _form_key = GlobalKey<FormState>();
  List<String> role=['Organizer','Attendee'];
  String? selectedRole;
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
            MaterialPageRoute(builder: (_) => BlocProvider(
  create: (context) => AuthBloc(),
  child: LoginView(),
)),
          );
        }
        if (state is BackendErrorState) {
          showDialog(
            context: context,
            builder: (_) =>
                Customdialogue(icon: state.icon, text: state.errorMsg ?? ''),
          );
        }

        if (state is SignUpSuccessfulState) {

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => VerifyOtp(email: state.email??'',previous:'signup')),
          );
        }
      },
      builder: (context, state) {
        return GradientScaffold(
          body: Stack(
            children: [
              SingleChildScrollView(
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
                                    Wrap(
                                        spacing: 50.w,
                                        children:role.map((role){
                                          final isSelected=selectedRole==role;
                                          return FilterChip(
                                            side: BorderSide(color: Color(0xFFFF6F61)),
                                            label: Text(role,
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 15.sp
                                              ),),
                                            autofocus: true,
                                            showCheckmark: true,
                                            backgroundColor: Color(0xFF928dab),
                                            iconTheme: IconThemeData(
                                                color: Colors.green
                                            ),
                                            clipBehavior: Clip.hardEdge,
                                            selected: isSelected,
                                            onSelected: (selected) {
                                              setState(() {
                                                if (selected) {
                                                  selectedRole=selected?role:null;
                                                  context.read<AuthBloc>().add(RoleButtonClicked(role: selectedRole??''));
                                                }
                                              });
                                            },
                                            selectedColor: Colors.redAccent.shade100,
                                            checkmarkColor: Colors.green,
                                          );
                                        }).toList()
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomInput(
                                      hint: "Enter your full name",
                                      controller: _username_controller,
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomInput(
                                      hint: "Enter your email",
                                      controller: _email_controller,
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomInput(
                                      hint: "Enter your password",
                                      controller: _password_controller,
                                      icon: notvisiblesignup
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      obsecure: notvisiblesignup,
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          EyeIconSignUpClicked(
                                            visibilty: notvisiblesignup,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 15.h),
                                    CustomInput(
                                      hint: "Confirm your password",
                                      controller: _confirm_controller,
                                      icon: notvisiblesignup
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      obsecure: notvisiblesignup,
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          EyeIconSignUpClicked(
                                            visibilty: notvisiblesignup,
                                          ),
                                        );
                                      },
                                    ),
                                    SizedBox(height: 5.h),
                                    if (state is ErrorState) ...[
                                      Padding(
                                        padding: EdgeInsets.only(left: 20.r),
                                        child: CustomText(
                                          color: Colors.redAccent,
                                          weight: FontWeight.w500,
                                          text: state.errorMsg ?? "",
                                        ),
                                      ),
                                    ],
                                    SizedBox(height: 10.h),
                                    CustomButton(
                                      text: "Sign Up",
                                      height: 40.h,
                                      width: 320.w,
                                      color: Color(0xFFFF6F61),
                                      border: 12,
                                      press: (){

                                        context.read<AuthBloc>().add(
                                          SignUpButtonClicked(
                                            key: _form_key.currentState!
                                                .validate(),
                                            username: _username_controller.text,
                                            email: _email_controller.text,
                                            password: _password_controller.text,
                                            cofirmpassword:
                                                _confirm_controller.text,
                                          ),
                                        );
                                      },
                                    ),

                                    SizedBox(height: 10.h),
                                    GestureDetector(
                                      onTap: () {
                                        context.read<AuthBloc>().add(
                                          LoginGestureClicked(),
                                        );
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
          ),
        );
      },
    );
  }
}
