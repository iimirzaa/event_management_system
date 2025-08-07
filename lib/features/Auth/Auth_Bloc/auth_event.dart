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
   final bool key;
   final String email;
   final String password;
   LoginButtonClicked({
   required this.key,
     required this.email,
     required this.password
});

}
class SignUpButtonClicked extends AuthEvent{
  final bool key;
  final String username;
  final String email;
  final String password;
  final String cofirmpassword;
  SignUpButtonClicked({
    required this.key,
    required this.username,
    required this.email,
    required this.password,
    required this.cofirmpassword,
});
}
class SendOtpClicked extends AuthEvent{
  final bool key;
  final String email;

  SendOtpClicked({
    required this.key,
    required this.email,

  });

}
class ForgetPasswordGestureClicked extends AuthEvent{}
