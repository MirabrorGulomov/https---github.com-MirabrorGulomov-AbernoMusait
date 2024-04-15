import 'package:bloc/bloc.dart';
import 'package:location/location.dart';
import 'package:meta/meta.dart';
import 'package:musait/repos/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository _repository;
  LocationBloc(this._repository) : super(LocationInitial()) {
    on<LocationEvent>((event, emit) async {
      if (event is RequestLocationEvent) {
        emit(LocationLoading());
        try {
          LocationData locationData = await _repository.getLocation();
          emit(LocationSucess(locationData));
        } catch (e) {
          emit(LocationFailed());
        }
      }
    });
  }
}
