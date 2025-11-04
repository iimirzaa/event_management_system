part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}
class LoadingState extends DashboardState{}
class MessageState extends DashboardState{
  final IconData icon;
  final String errorMessage;
  MessageState({
    required this.icon,
    required this.errorMessage
  });
}
//Attendee Dashboard States
class ViewDetailButtonClickedState extends DashboardState{
  final List<dynamic> details;
  ViewDetailButtonClickedState({
    required this.details
  });
}
class EventLoadedState extends DashboardState{
  final List<dynamic> events;
  final List<dynamic> bookedEvents;
  EventLoadedState({
    required this.events,
    required this.bookedEvents
  });
}
//Organizer Dashboard States
class CreateEventButtonState extends DashboardState{}
class OrganizerEventLoadedState extends DashboardState{
  final List<dynamic> events;
  OrganizerEventLoadedState({
    required this.events
  });
}


