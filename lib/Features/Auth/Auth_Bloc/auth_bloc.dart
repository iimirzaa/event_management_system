import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../../../Repository/auth_repository.dart';
import '../../../Services/token_storage.dart';
import '../../../Services/validator.dart';

import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
part 'auth_event.dart';
part 'auth_state.dart';
part 'handler.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? role;
  Future<String> getDeviceModel() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model ?? "Unknown Android Device";
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.name ?? "Unknown iOS Device";
    } else {
      return "Unknown Device";
    }
  }
  List<IconData> icon = [
    Icons.wifi_off,
    Icons.error_outline, // 400 - Bad Request
    Icons.warning_amber_rounded, // 500 - Internal Server Error
  ];
  AuthBloc() : super(AuthInitial()) {
    on<RoleButtonClicked>((event, emit) {
      role = event.role;
      emit(RoleButtonState(role: event.role));
    });
    on<EyeIconClicked>((event, emit) {
      emit(EyeIconState(visibilty: !event.visibilty, role: role));
    });
    on<EyeIconSignUpClicked>((event, emit) {
      emit(EyeIconSignUpState(visibilty: !event.visibilty, role: role));
    });
    on<LoginButtonClicked>((event, emit)async {
      final email = event.email.trim();
      final password = event.password.trim();
      String deviceModel = await getDeviceModel();
      if (role == null || role!.isEmpty) {
        emit(ErrorState(errorMsg: "Please select a role"));
        return;
      }

      final emailError = Validator.validateEmail(email);
      if (emailError != null) {
        emit(ErrorState(errorMsg: emailError));
        return;
      }

      // Password validation
      final passwordError = Validator.validatePassword(password);
      if (passwordError != null) {
        emit(ErrorState(errorMsg: passwordError));
        return;
      }
      if (event.key == true) {
        emit(LoadingState());
        print(email);
        Map<String,dynamic> response= await AuthProvider().Login({
          'email':email,
          'password':password,
          'role':role,
          'device_model': deviceModel,
        });
        print(response);
        final handler= Handler();
        handler.handleUserLogin(response: response, emit: emit, icons: icon);
        return;
      }
    });

    on<LoginGestureClicked>((event, emit) {
      emit(LoginGestureState());
    });
    on<SignUpClicked>((event, emit) {
      emit(SignUpState());
    });
    on<SignUpButtonClicked>((event, emit) async {
      final username = event.username;
      final email = event.email.trim();
      final password = event.password.trim();
      final confirmpassword = event.cofirmpassword.trim();
      if (role == null || role!.isEmpty) {
        emit(ErrorState(errorMsg: "Please select a role"));
        return;
      }
      final nameerror= Validator.validateUsername(username);
      if (nameerror!=null) {
        emit(ErrorState(errorMsg: "Enter a valid full name (first and last)"));
        return;
      }
      if (username.length < 3 || username.length > 30) {
        emit(
          ErrorState(errorMsg: "Username should have at least 3+ character"),
        );
      }
      final emailError = Validator.validateEmail(email);
      if (emailError != null) {
        emit(ErrorState(errorMsg: emailError));
        return;
      }

      // Password validation
      final passwordError = Validator.validatePassword(password);
      if (passwordError != null) {
        emit(ErrorState(errorMsg: passwordError));
        return;
      }
      if (password != confirmpassword) {
        emit(ErrorState(errorMsg: "Password did not match!"));
        return;
      }

      if (event.key == true) {
        emit(LoadingState());
        Map<String, dynamic> response = await AuthProvider().sendSignUpOTP({
          "username": username,
          "email": email,
          "password": password,
          "role": role,
        });
        final handler = Handler();
        handler.handleSignUpResponse(
          response: response,
          emit: emit,
          icons: icon,
          email: email
        );
      }
    });
    on<VerifyOtpClicked>((event,emit)async{
      final email=event.email;
      final otp=event.otp;
      emit(LoadingState());
      final emailError = Validator.validateEmail(email);
      if (emailError != null) {
        emit(ErrorState(errorMsg: emailError));
        return;
      }

      if(event.key==true) {
        Map<String, dynamic> response = await AuthProvider().verifyOtp({
          "email": email,
          "otp": otp,
        });
        final handler = Handler();
        handler.handleVerifyOtp(
          response: response,
          emit: emit,
          icons: icon,
        );
      }


    });
    on<ForgetPasswordGestureClicked>((event, emit) {
      emit(ForgetPasswordNavigationState());
    });
    on<SendOtpClicked>((event, emit) async {
      String email = event.email.trim();
      print(email);

      emit(LoadingState());
      final emailError = Validator.validateEmail(email);
      if (emailError != null) {
        emit(ErrorState(errorMsg: emailError));
        return;
      }
      if (event.key == true) {

        Map<String, dynamic> response=await AuthProvider().sendOTP({"email": email});
        final handler=Handler();
        handler.handleSendOtp(response: response, emit: emit, icons: icon);
      }
    });
    on<ChangePasswordClickedEvent>((event,emit)async{
      String email=event.email.trim();
      final password = event.password.trim();
      final confirmPassword = event.cofirmpassword.trim();
      final passwordError = Validator.validatePassword(password);
      if (passwordError != null) {
        emit(ErrorState(errorMsg: passwordError));
        return;
      }
      if (password != confirmPassword) {
        emit(ErrorState(errorMsg: "Password did not match!"));
        return;
      }
      if(event.key==true){
        emit(LoadingState());
        Map<String,dynamic> response= await AuthProvider().changePassword({
          'email':email,
          'password':password
        });
        Handler handler=Handler();
        handler.handleChangePassword(response: response, emit: emit, icons: icon);
      }

    });
  }
}
