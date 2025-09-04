part of 'event_bloc.dart';

@immutable
sealed class EventState {}

final class EventInitial extends EventState {}
//Mutual Events Handling
class LoadingState extends EventState{}
class MessageState extends EventState{
  final IconData icon;
  final String errorMessage;
  MessageState({
    required this.icon,
    required this.errorMessage
});
}
//Organizer Side Event handling
class CreateEventButtonState extends EventState{}
class EventCreationSuccessfulState extends EventState{}

//Attendee Side Event handling
