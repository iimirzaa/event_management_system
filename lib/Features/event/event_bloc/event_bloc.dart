import 'package:bloc/bloc.dart';
import 'package:event_management_system/Services/event_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../Services/validator.dart';
import '../../../Repository/event_repository.dart';

part 'event_event.dart';
part 'event_state.dart';
part 'event_handler.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    List<IconData> icon = [
      Icons.wifi_off,
      Icons.error_outline, // 400 - Bad Request
      Icons.warning_amber_rounded, // 500 - Internal Server Error
    ];
    on<CreateEventButtonClicked>((event, emit) async{
      String? eventError=Validator.validateEventName(event.eventName.trim());
      String? capacityError=Validator.validateCapacity(event.capacity.trim());
      String? categoryError=Validator.validateCategories(event.category);
      String? serviceError=Validator.validateServices(event.service);
      String? imageError=Validator.validateImages(event.images);
      String? locationError=Validator.validateLocation(event.street.trim(), event.town.trim(), event.city.trim());
      if(eventError!=null){
        emit(MessageState(icon: Icons.warning_amber_sharp, errorMessage:eventError));
        return;
      }
      if(capacityError!=null){
        emit(MessageState(icon: Icons.group_off, errorMessage:capacityError));
        return;
      }
      if(categoryError!=null){
        emit(MessageState(icon: Icons.category_outlined, errorMessage:categoryError));
        return;
      }
      if(serviceError!=null){
        emit(MessageState(icon: Icons.restaurant, errorMessage:serviceError));
        return;
      }
      // if(imageError!=null){
      //   emit(MessageState(icon: Icons.broken_image_outlined, errorMessage:imageError));
      //   return;
      // }
      if(locationError!=null){
        emit(MessageState(icon: Icons.location_off_outlined, errorMessage:locationError));
        return;
      }

      if(event.key==true){
        emit(LoadingState());
        Map<String, dynamic> response = await EventProvider().createEvent({
          "eventName": event.eventName.trim(),
          "category": event.category,
          "service": event.service,
          "capacity": event.capacity.trim(),
          "street":event.street.trim(),
          "town":event.town.trim(),
          "city":event.city.trim()
        });
        final handler = EventHandler();
        handler.handleEventCreation(
            response: response,
            emit: emit,
            icons: icon,
        );
      }
    });
    on<LoadEvents>((event,emit)async{
      emit(LoadingState());
      try {
        final response = await EventProvider().loadEvents();
        print('response received');
        print(response);

        if (response['success'] == true) {
          print('trying');

          final events = (response['events'] as List)
              .map((e) => Event.fromMap(e as Map<String, dynamic>))
              .toList();


          emit(EventLoadedState(events: events)); // your custom state
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
