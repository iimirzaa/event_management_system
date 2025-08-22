part of 'auth_bloc.dart';

class Handler {
  void handleSignUpResponse({
    required Map<String, dynamic> response,
    required Emitter<AuthState> emit,
    required List<IconData> icons,
    required String email,
  }) {
    if (response['success']) {
      emit(SignUpSuccessfulState(email: email));
      return;
    }

    final msg = response['message'];

    if (msg == 'Connection timeout' ||
        msg == 'Receive timeout' ||
        msg == 'No internet connection') {
      emit(BackendErrorState(errorMsg: msg, icon: icons[0]));
    } else if (msg == 'Unexpected error occurred') {
      emit(BackendErrorState(errorMsg: msg, icon: icons[2]));
    } else {
      emit(BackendErrorState(errorMsg: msg, icon: icons[1]));
    }
  }

  void handleVerifyOtp({
    required Map<String, dynamic> response,
    required Emitter<AuthState> emit,
    required List<IconData> icons,
  }) {
    if (response['success']) {
      emit(VerificationSuccessful());
      return;
    }

    final msg = response['message'];


    if (msg == 'Connection timeout' ||
        msg == 'Receive timeout' ||
        msg == 'No internet connection') {
      emit(BackendErrorState(errorMsg: msg, icon: icons[0]));

    } else if (msg == 'Unexpected error occurred') {
      emit(BackendErrorState(errorMsg: msg, icon: icons[2]));

    } else {
      emit(BackendErrorState(errorMsg: msg, icon: icons[1]));
    }
  }
  void handleUserLogin({
    required Map<String, dynamic> response,
    required Emitter<AuthState> emit,
    required List<IconData> icons,
  }) {
    if (response['success']) {
      emit(VerificationSuccessful());
      return;
    }

    final msg = response['message'];

    if (msg == 'Connection timeout' ||
        msg == 'Receive timeout' ||
        msg == 'No internet connection') {
      emit(BackendErrorState(errorMsg: msg, icon: icons[0]));

    } else if (msg == 'Unexpected error occurred') {
      emit(BackendErrorState(errorMsg: msg, icon: icons[2]));

    } else {
      emit(BackendErrorState(errorMsg: msg, icon: icons[1]));
    }
  }
}
