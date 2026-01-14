import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeoLocationService {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  StreamSubscription<Position>? _positionStreamSubscription;

  //to Check if the permission is true or false
  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return Future.error('Location Services are disabled');
    }

    permission = await _geolocatorPlatform.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions ',
      );
    }

    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  //This returns a Position , that can be null for example if the permission is not granted, otherwise we get the currentPosition
  Future<Position?> getCurrentPosition() async {
    final hasPermission = await checkPermission();

    if (!hasPermission) {
      return null;
    }

    return await _geolocatorPlatform.getCurrentPosition();
  }

  StreamSubscription<Position> getPositionStream(
    void Function(Position) onPositionChanged,
  ) {
    _positionStreamSubscription = _geolocatorPlatform
        .getPositionStream()
        .listen(onPositionChanged);

    return _positionStreamSubscription!;
  }

  void cancelPositionStream() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }
}
