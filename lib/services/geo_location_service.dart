import 'dart:async';

import 'package:geolocator/geolocator.dart';

class GeolocationService {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  Future<bool> checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();

    if (!serviceEnabled) {
      return false;
    }

    permission =
        await _geolocatorPlatform
            .checkPermission(); //we check for the permission first. (at this point the service is Enabled so it has happened that check (it needs to pass two)

    if (permission == LocationPermission.denied) {
      //if its denied, we need to ask again for the permission
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        return false; //here after being originally denied, and checked again, it finally is definitely not accessed
      }
    }

    return permission ==
            LocationPermission
                .always || //all other cases would exit with a false
        permission == LocationPermission.whileInUse;
  }

  Future<Position?> getCurrentPosition() async {
    final LocationSettings locationSettings = LocationSettings(
      timeLimit: Duration(seconds: 10),
    );

    final hasPermission = await checkPermission();

    if (!hasPermission) {
      return null;
    }

    final lastKownn =
        await _geolocatorPlatform
            .getLastKnownPosition(); //function signature is Future<Position?>, means it can return null

    try {
      final currentPosition = await _geolocatorPlatform.getCurrentPosition(
        //function signature is Future<Position> means it can't return null, so failure has to be that it throws an error
        locationSettings: locationSettings,
      );

      print("Current position is $currentPosition");
      return currentPosition; //returns in latitude, longitude format.
    } catch (_) {
      return lastKownn;
    }
  }
}
