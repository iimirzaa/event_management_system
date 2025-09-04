import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    //Attendee Events Handling
    on<ViewDetailButtonClicked>((event, emit) {
      emit(ViewDetailButtonClickedState());
    });
    //Organizer Events Handling
    on<CreateEventButtonClicked>((event,emit){
      emit(CreateEventButtonState());
    });
  }
}
