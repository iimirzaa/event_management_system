part of 'event_bloc.dart';

class EventHandler{
  void handleSignUpResponse({
    required Map<String, dynamic> response,
    required Emitter<EventState> emit,
    required List<IconData> icons,
    required String email,
  }) {
    if (response['success']) {
      emit(EventCreationSuccessfulState());
      return;
    }

    final msg = response['message'];

    if (msg == 'Connection timeout' ||
        msg == 'Receive timeout' ||
        msg == 'No internet connection') {
      emit(MessageState(errorMessage: msg, icon: icons[0]));
    } else if (msg == 'Unexpected error occurred') {
      emit(MessageState(errorMessage: msg, icon: icons[2]));
    } else {
      emit(MessageState(errorMessage: msg, icon: icons[1]));
    }
  }

}