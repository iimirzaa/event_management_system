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
  final List<String> category;
  final List<String> service;
  CreateEventButtonClicked({
    required this.key,
    required this.eventName,
    required this.capacity,
    required this.images,
    required this.street,
    required this.town,
    required this.city,
    required this.service,
    required this.category
});
}
//Attendee Side
class BookEventButtonCLicked extends EventEvent{
  final String eventId;
  final String eventDetail;
  final List<String> service;
  final List<String> category;
  final String capacity;
  BookEventButtonCLicked({
    required this.eventId,
    required this.eventDetail,
    required this.service,
    required this.category,
    required this.capacity
});

}
