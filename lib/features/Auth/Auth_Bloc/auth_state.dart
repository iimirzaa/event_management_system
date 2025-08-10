part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RoleButtonState extends AuthState {
  final String role;
  RoleButtonState({required this.role});
}

class EyeIconState extends AuthState {
  final bool visibilty;
  final String? role;
  EyeIconState({required this.visibilty,required this.role});
}

class EyeIconSignUpState extends AuthState {
  final bool visibilty;
  final String? role;

  EyeIconSignUpState({required this.visibilty,required this.role});
}

class ErrorState extends AuthState {
  final String? errorMsg;
  ErrorState({this.errorMsg});
}
class BackendErrorState extends AuthState {
  final String? errorMsg;
  final IconData? icon;
  BackendErrorState({this.errorMsg,this.icon});
}
class LoadingState extends AuthState{}
class LoginSuccessfulState extends AuthState {}
class SignUpSuccessfulState extends AuthState{}

class LoginGestureState extends AuthState {}

class SignUpState extends AuthState {}
class SignUpButtonState extends AuthState {}
class ForgetPasswordState extends AuthState{}
class SendOtpSuccessfulState extends AuthState{}
