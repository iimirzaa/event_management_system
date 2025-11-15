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
class LoadEvents extends DashboardEvent{}

//Organizer Dashboard Events
class CreateEventButtonClicked extends DashboardEvent{}
class LoadOrganizerEvents extends DashboardEvent{}
class SaveProfilePicClicked extends DashboardEvent{
  final XFile? img;
  SaveProfilePicClicked({
    required this.img
});
}

