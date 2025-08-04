part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
class RoleButtonState extends AuthState{
  final String role;
  RoleButtonState({
    required this.role
});
}

class EyeIconState extends AuthState{
final bool visibilty;
EyeIconState({
  required this.visibilty
});
}
class EyeIconSignUpState extends AuthState{
  final bool visibilty;
  EyeIconSignUpState({
    required this.visibilty
  });
}
class LoginGestureState extends AuthState{}
class SignUpState extends AuthState{}
class LoginErrorState extends AuthState{
  final String? errorMsg;
  LoginErrorState({
    this.errorMsg
});

}
class SignUpButtonState extends AuthState{}

