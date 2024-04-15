part of 'location_bloc.dart';

@immutable
abstract class LocationState {}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationSucess extends LocationState {
  final LocationData locationData;

  LocationSucess(this.locationData);
}

class LocationFailed extends LocationState {}
