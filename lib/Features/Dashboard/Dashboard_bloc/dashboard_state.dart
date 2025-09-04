part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}
//Attendee Dashboard States
class ViewDetailButtonClickedState extends DashboardState{

}
//Organizer Dashboard States
class CreateEventButtonState extends DashboardState{}
