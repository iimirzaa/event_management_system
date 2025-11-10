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
class EventLoadedState extends EventState{
  final List<dynamic> events;
  EventLoadedState({
    required this.events
});
}
class CreateEventButtonState extends EventState{}
class EventSuccessfulState extends EventState{}

//Attendee Side Event handling
class BookEventButtonState extends EventState{}
class NotificationLoadedState extends EventState{
  final List<dynamic> notification;
  NotificationLoadedState({
    required this.notification
});
}
