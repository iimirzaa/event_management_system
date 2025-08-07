

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  String? role;
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
    on<LoginButtonClicked>((event, emit) {
      final email = event.email.trim();
      final password = event.password.trim();
      print(role);
      if (role == null || role!.isEmpty) {
        emit(ErrorState(errorMsg: "Please select a role"));
        return;
      }

      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emit(ErrorState(errorMsg: "Enter a valid email address"));
        return;
      }

      // Password validation
      final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
      );
      if (!passwordRegex.hasMatch(password)) {
        emit(
          ErrorState(
            errorMsg:
                "Password must be 8+ characters with upper, lower, number",
          ),
        );
        return;
      }
      if (event.key == true) {
        emit(LoadingState());
        return;
      }
    });

    on<LoginGestureClicked>((event, emit) {
      emit(LoginGestureState());
    });
    on<SignUpClicked>((event, emit) {
      emit(SignUpState());
    });
    on<SignUpButtonClicked>((event, emit) {
      final username = event.username;
      final email = event.email.trim();
      final password = event.password.trim();
      final confirmpassword = event.cofirmpassword.trim();
      print(role);
      if (role == null || role!.isEmpty) {
        emit(ErrorState(errorMsg: "Please select a role"));
        return;
      }
      final nameRegex = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)+$");
      if (!nameRegex.hasMatch(username)) {
        emit(ErrorState(errorMsg: "Enter a valid full name (first and last)"));
        return;
      }
      if (username.length < 3 || username.length > 30) {
        emit(
          ErrorState(errorMsg: "Username should have at least 3+ character"),
        );
      }
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emit(ErrorState(errorMsg: "Enter a valid email address"));
        return;
      }

      // Password validation
      final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,16}$',
      );
      if (!passwordRegex.hasMatch(password)) {
        emit(
          ErrorState(
            errorMsg:
                "Password must have  8 to 16 characters with upper, lower, number",
          ),
        );
        return;
      }
      if (password != confirmpassword) {
        emit(ErrorState(errorMsg: "Password did not match!"));
      }

      if (event.key == true) {
        emit(LoadingState());
        return;
      }
    });
    on<ForgetPasswordGestureClicked>((event,emit){
           emit(ForgetPasswordState());
    });
    on<SendOtpClicked>((event,emit){
        if(event.key==true){
          emit(LoadingState());
          return;
        }
        String email=event.email.trim();
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(email)) {
          emit(ErrorState(errorMsg: "Enter a valid email address"));
          return;
        }
      });
  }

}
