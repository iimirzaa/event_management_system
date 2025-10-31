import 'package:event_management_system/CustomWidget/Customdialogue.dart';
import 'package:event_management_system/Features/Auth/forget_password/change_password.dart';
import 'package:event_management_system/Scaffold_Theme/scaffold_gradient.dart';
import 'package:flutter/material.dart';
import 'package:event_management_system/CustomWidget/CustomButton.dart';
import 'package:event_management_system/CustomWidget/CustomText.dart';
import 'package:event_management_system/Features/Auth/Login/login_view.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../Auth_Bloc/auth_bloc.dart';

class SendOtp extends StatefulWidget {
  final String email;
  final String previous;
  const SendOtp({super.key, required this.email,required this.previous});

  @override
  State<SendOtp> createState() => _SendOtpState();
}

class _SendOtpState extends State<SendOtp> {
  final List<TextEditingController> _controller = List.generate(
    4,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusnode = List.generate(4, (_) => FocusNode());
  @override
  void dispose() {
    for (var c in _controller) {
      c.dispose();
    }
    for (var f in _focusnode) {
      f.dispose();
    }
    super.dispose();
  }

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 3) {
        FocusScope.of(context).requestFocus(_focusnode[index + 1]);
      } else {
        _focusnode[index].unfocus(); // done typing
      }
    } else {
      if (index > 0) {
        FocusScope.of(context).requestFocus(_focusnode[index - 1]);
      }
    }
  }

  final _form_key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is VerificationSuccessful && widget.previous=='signup') {
          await showDialog(
            context: context,
            builder: (_) => Customdialogue(
              icon: Icons.check_circle,
              text: "Sign up Successful!",
              color: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => LoginView()),
          );
        }else{
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (_)=> ChangePasswordView(previous: widget.previous,)));

        }
        if(state is BackendErrorState){
          showDialog(context: context, builder: (_)=>Customdialogue(icon: state.icon, text: state.errorMsg??''));
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
                          SizedBox(height: 200.h),
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
                                    SizedBox(height: 15.h),
                                    CustomText(
                                      text:
                                          "Enter the OTP sent to your email address: ${widget.email}.",
                                      color: Colors.grey,
                                      weight: FontWeight.w400,
                                      size: 20.sp,
                                    ),
                                    SizedBox(height: 15.h),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: List.generate(4, (index) {
                                        return TextFormField(
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 25.sp,
                                          ),
                                          onChanged: (value) => _onChanged(
                                            index,
                                            _controller[index].text.trim(),
                                          ),
                                          showCursor: false,
                                          maxLength: 1,
                                          focusNode: _focusnode[index],
                                          controller: _controller[index],
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          decoration: InputDecoration(
                                            constraints: BoxConstraints(
                                              minHeight: 50.h,
                                              maxHeight: 50.h,
                                              minWidth: 50.h,
                                              maxWidth: 50.h,
                                            ),
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                  vertical: 8.h,
                                                  horizontal: 16.w,
                                                ),
                                            filled: true,
                                            fillColor: Colors.white.withAlpha(
                                              50,
                                            ),
                                            counterText: "",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              borderSide: BorderSide(
                                                color: Color(0xFFFF6F61),
                                                width: 2,
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              borderSide: BorderSide(
                                                color: Color(0xFFFF6F61),
                                                width: 2,
                                              ),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12.r),
                                              borderSide: BorderSide(
                                                color: Colors.redAccent,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                    SizedBox(height: 5.h),
                                    if(state is ErrorState)...[

                                        Padding(
                                          padding: EdgeInsets.only(left: 20.r),
                                          child: CustomText(
                                            color: Colors.redAccent,
                                            weight: FontWeight.w500,
                                            text: state.errorMsg ?? "",
                                          ),
                                        ),

                                    ],
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    CustomButton(
                                      text: "Verify OTP",
                                      height: 40.h,
                                      width: 320.w,
                                      color: Color(0xFFFF6F61),
                                      press: () {
                                        context.read<AuthBloc>().add(
                                          VerifyOtpClicked(
                                            email: widget.email,
                                            key: _form_key.currentState!
                                                .validate(),
                                            otp: _controller
                                                .map((c) => c.text)
                                                .join(''),
                                          ),
                                        );
                                      },
                                      border: 12,
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
