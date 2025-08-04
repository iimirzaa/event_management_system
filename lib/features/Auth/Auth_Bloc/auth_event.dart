part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}
class RoleButtonClicked extends AuthEvent{
  final String role;
  RoleButtonClicked({
    required this.role
});
}
class EyeIconClicked extends AuthEvent{
final bool visibilty;
EyeIconClicked({
  required this.visibilty
});
}
class EyeIconSignUpClicked extends AuthEvent{
  final bool visibilty;
  EyeIconSignUpClicked({
    required this.visibilty
  });
}
class SignUpClicked extends AuthEvent{}
class LoginGestureClicked extends AuthEvent{}
class LoginButtonClicked extends AuthEvent{
   final FormState key;
   LoginButtonClicked({
   required this.key
});




}
