part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}
//Attendee Dashboard States
class ViewDetailButtonClickedState extends DashboardState{
  final List<dynamic> details;
  ViewDetailButtonClickedState({
    required this.details
  });
}
//Organizer Dashboard States
class CreateEventButtonState extends DashboardState{}
class LoadingState extends DashboardState{}
class MessageState extends DashboardState{
  final IconData icon;
  final String errorMessage;
  MessageState({
    required this.icon,
    required this.errorMessage
  });
}
//Organizer Side Event handling
class EventLoadedState extends DashboardState{
  final List<dynamic> events;
  EventLoadedState({
    required this.events
  });
}
