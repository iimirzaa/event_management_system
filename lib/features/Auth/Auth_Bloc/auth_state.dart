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
class SignUpState extends AuthState{}
class LoginButtonState extends AuthState{

}
