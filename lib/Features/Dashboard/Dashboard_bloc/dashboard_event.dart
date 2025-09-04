part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}
//Attendee Dashboard Events
class ViewDetailButtonClicked extends DashboardEvent{

}
//Organizer Dashboard Events
class CreateEventButtonClicked extends DashboardEvent{}
