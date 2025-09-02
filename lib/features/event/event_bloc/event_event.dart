part of 'event_bloc.dart';

@immutable
sealed class EventEvent {}
//Organizer Side Event handling
class CreateEventButtonClicked extends EventEvent{
  final bool key;
  final String eventName;
  final String capacity;
  final String street;
  final String town;
  final String city;
  final List<XFile> images;
  CreateEventButtonClicked({
    required this.key,
    required this.eventName,
    required this.capacity,
    required this.images,
    required this.street,
    required this.town,
    required this.city
});
}
