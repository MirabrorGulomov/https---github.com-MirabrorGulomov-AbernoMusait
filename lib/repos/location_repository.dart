import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';

class LocationRepository {
  final Location _location = Location();
  final LocationData mainLocation = LocationData.fromMap({
    "latitude": 41.3052956,
    "longitude": 69.2807633,
  });

  Future<LocationData> getLocation() async {
    bool serviceEnabled = await _location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _location.requestService();
      if (!serviceEnabled) {
        throw 'Location services are disabled.';
      }
    }

    PermissionStatus permissionGranted = await _location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        throw 'Location permissions are denied.';
      }
    }

    return await _location.getLocation();
  }

  double calculateDistance(LocationData start, LocationData end) {
    double distanceInMeters = Geolocator.distanceBetween(
      start.latitude!,
      start.longitude!,
      end.latitude!,
      end.longitude!,
    );
    return distanceInMeters;
  }
}
