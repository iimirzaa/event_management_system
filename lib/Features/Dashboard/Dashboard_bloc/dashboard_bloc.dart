import 'package:bloc/bloc.dart';
import 'package:event_management_system/Repository/event_repository.dart';
import 'package:event_management_system/Services/event_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    //Attendee Events Handling
    on<ViewDetailButtonClicked>((event, emit) {
      emit(ViewDetailButtonClickedState(details:event.details));
    });
    on<LoadEvents>((event,emit)async{
      emit(LoadingState());
      try {
        final response = await EventProvider().loadEvents();

        if (response['success'] == true) {
          final List<dynamic> data=response['bookedEvents'];
          print("Your data is :+ $data");
          final events = (response['events'] as List)
              .map((e) => Event.fromMap(e as Map<String, dynamic>))
              .toList();


          emit(EventLoadedState(events: events,bookedEvents:data)); // your custom state
        } else {
          emit(MessageState(
            icon: Icons.warning_amber_sharp,
            errorMessage: 'Error while loading events',
          ));

        }
      } catch (e, st) {
        print('Error while loading: $e');
        print(st);
        emit(MessageState(
          errorMessage: "Unexpected error: $e",
          icon: Icons.error_outline,
        ));
      }

    });
    //Organizer Events Handling
    on<CreateEventButtonClicked>((event,emit){
      emit(CreateEventButtonState());
    });
    on<LoadOrganizerEvents>((event,emit)async{
      emit(LoadingState());
      try {
        final response = await EventProvider().loadOrganizerEvents();

        if (response['success'] == true) {

          final List<dynamic> eventList = response['events']['events'];
             final events= eventList.map((e) => Event.fromMap(e as Map<String, dynamic>))
              .toList();
            print(events);

          emit(OrganizerEventLoadedState(events: events)); // your custom state
        } else {
          emit(MessageState(
            icon: Icons.warning_amber_sharp,
            errorMessage: 'Error while loading events',
          ));

        }
      } catch (e, st) {
        print('Error while loading: $e');
        print(st);
        emit(MessageState(
          errorMessage: "Unexpected error: $e",
          icon: Icons.error_outline,
        ));
      }

    });

  }
}
