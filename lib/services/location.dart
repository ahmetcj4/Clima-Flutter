import 'package:geolocator/geolocator.dart';

class Location {
  double lat;
  double lon;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
      lat = position.latitude;
      lon = position.longitude;
    } catch (e) {
      lat = 0;
      lon = 0;
    }
  }
}
