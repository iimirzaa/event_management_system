import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<EyeIconClicked>((event, emit) {
      emit(EyeIconState(visibilty: !event.visibilty));
    });
    on<EyeIconSignUpClicked>((event, emit) {
      emit(EyeIconSignUpState(visibilty: !event.visibilty));
    });
    on<RoleButtonClicked>((event,emit){
      emit(RoleButtonState(role: event.role));
    });
    on<LoginGestureClicked>((event,emit){
      emit(LoginGestureState());
    });
    on<SignUpClicked>((event,emit){
      emit(SignUpState());
    });
    on<SignUpButtonClicked>((event,emit){
      emit(SignUpButtonState());
    });
  }
}
