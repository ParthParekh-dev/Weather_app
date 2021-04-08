import 'package:geolocator/geolocator.dart';
import 'dart:math';

class Location {
  double latitude, longitude;

  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;

      // latitude = Random().nextInt(91);
      // longitude = Random().nextInt(181);
    } catch (e) {
      print(e);
    }
  }
}
