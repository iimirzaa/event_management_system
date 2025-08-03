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
    on<RoleButtonClicked>((event,emit){
      emit(RoleButtonState(role: event.role));
    });
    on<SignUpClicked>((event,emit){
      emit(SignUpState());
    });
  }
}
