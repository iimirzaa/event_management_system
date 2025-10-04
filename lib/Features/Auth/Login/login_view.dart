import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/CustomWidget/custominput.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:event_management_system/features/Auth/forget_password/email_view.dart';
import 'package:event_management_system/features/Auth/signup/signup_view.dart';
import 'package:event_management_system/features/Dashboard/attendee_dashboard.dart';
import 'package:event_management_system/features/Dashboard/organizer_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Auth_Bloc/auth_bloc.dart';
import'../../../CustomWidget/Customdialogue.dart';
import '../../../Services/token_storage.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _email_controller = TextEditingController();
  final _password_controller = TextEditingController();
  bool notvisible = true;
  final _form_key = GlobalKey<FormState>();
  List<String> role=['Organizer','Attendee'];
    String? selectedRole;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async{
        if (state is EyeIconState) {
          setState(() {
            notvisible = state.visibilty;
          });
        }
        if (state is SignUpState) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => SignupView()),
          );
        }
        if(state is LoginSuccessful){
         final String? role= await TokenStorage.getRole();
         if(role=='Attendee') {
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (_) => const AttendeeDashboard()),
                 (Route<dynamic> route) => false,
           );
         }else if(role=='Organizer'){
           Navigator.pushAndRemoveUntil(
             context,
             MaterialPageRoute(builder: (_) => const OrganizerDashboard()),
                 (Route<dynamic> route) => false,
           );
         }
        }
        if (state is BackendErrorState) {
          showDialog(
            context: context,
            builder: (_) =>
                Customdialogue(icon: state.icon, text: state.errorMsg ?? ''),
          );
        }
        if(state is ForgetPasswordState){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>EmailView()));
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
                      padding: EdgeInsets.all(20.0.r),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                        ),child: Padding(
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
                                    hint: "Enter your email",
                                    controller: _email_controller,
                                  ),
                                  SizedBox(height: 15.h),
                                  CustomInput(
                                    hint: "Enter your password",
                                    controller: _password_controller,
                                    icon: notvisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    obsecure: notvisible,
                                    onTap: () {
                                      context.read<AuthBloc>().add(
                                        EyeIconClicked(visibilty: notvisible),
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
                                    text: "Login",
                                    height: 40.h,
                                    width: 320.w,
                                    color: Color(0xFFFF6F61),
                                    border: 12,
                                    press: () {
                                      context.read<AuthBloc>().add(
                                        LoginButtonClicked(
                                          key: _form_key.currentState!
                                              .validate(),
                                          email: _email_controller.text,
                                          password: _password_controller.text,
                                        ),
                                      );
                                    },
                                  ),
                                  SizedBox(height: 15.h),
                                  GestureDetector(
                                    onTap: (){
                                      context.read<AuthBloc>().add(ForgetPasswordGestureClicked());
                                    },
                                    child: Text(
                                      "Forget Password?",
                                      style: TextStyle(
                                        color: Color(0xffB8001F),
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.h),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<AuthBloc>().add(
                                        SignUpClicked(),
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Create Account?",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        Text(
                                          "Sign Up",
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
