import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../Services/validator.dart';

part 'event_event.dart';
part 'event_state.dart';
part 'event_handler.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<CreateEventButtonClicked>((event, emit) {
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
      if(imageError!=null){
        emit(MessageState(icon: Icons.broken_image_outlined, errorMessage:imageError));
        return;
      }
      if(locationError!=null){
        emit(MessageState(icon: Icons.location_off_outlined, errorMessage:locationError));
        return;
      }

      if(event.key==true){
        emit(LoadingState());
      }
    });
  }
}
