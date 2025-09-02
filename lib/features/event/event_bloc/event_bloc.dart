import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import '../../../services/validator.dart';

part 'event_event.dart';
part 'event_state.dart';

class EventBloc extends Bloc<EventEvent, EventState> {
  EventBloc() : super(EventInitial()) {
    on<CreateEventButtonClicked>((event, emit) {
      String? eventError=Validator.validateEventName(event.eventName.trim());
      String? capacityError=Validator.validateCapacity(event.capacity.trim());
      String? imageError=Validator.validateImages(event.images);
      if(eventError!=null){
        emit(MessageState(icon: Icons.warning_amber_sharp, errorMessage:eventError));
        return;
      }
      if(capacityError!=null){
        emit(MessageState(icon: Icons.group_off, errorMessage:capacityError));
        return;
      }
      if(imageError!=null){
        emit(MessageState(icon: Icons.broken_image_outlined, errorMessage:imageError));
        return;
      }

      if(event.key==true){
        emit(LoadingState());
      }
    });
  }
}
