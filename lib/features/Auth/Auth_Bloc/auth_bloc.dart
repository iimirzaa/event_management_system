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
      emit(EyeIconSignUpState(visibilty: !event.visibilty));
    });
    on<LoginButtonClicked>((event, emit) {
      final email = event.email.trim();
      final password = event.password.trim();
      if (event.key == true) {
        emit(LoginLoadingState());
      }

      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(email)) {
        emit(LoginErrorState(errorMsg: "Enter a valid email address"));
        return;
      }

      // Password validation
      final passwordRegex = RegExp(
        r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)[A-Za-z\d]{8,}$',
      );
      if (!passwordRegex.hasMatch(password)) {
        emit(
          LoginErrorState(
            errorMsg:
                "Password must be 8+ characters with upper, lower, number",
          ),
        );
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
      emit(SignUpButtonState());
    });
  }
}
