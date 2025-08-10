part of 'auth_bloc.dart';

class Handler{
  void handleSignUpResponse({
    required Map<String, dynamic> response,
    required Emitter<AuthState> emit,
    required List<IconData> icons,
  }) {
    if (response['success']) {
      emit(SignUpSuccessfulState());
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

