part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}
//Attendee Dashboard Events
class ViewDetailButtonClicked extends DashboardEvent{
final List<dynamic> details;
ViewDetailButtonClicked({
  required this.details
});
}
//Organizer Dashboard Events
class CreateEventButtonClicked extends DashboardEvent{}
class LoadEvents extends DashboardEvent{}

