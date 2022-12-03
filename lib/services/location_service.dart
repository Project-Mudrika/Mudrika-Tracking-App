import 'package:geolocator/geolocator.dart';
import 'package:live_tracking/services/websocket_service.dart';
import 'dart:io';

class LocationService {
  final WebSocketService _socketService = WebSocketService();

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  sendLocationUpdates(Stream<Position> location) {
    location.forEach((position) {
      print(" ${position.latitude} , ${position.longitude} ");
      _socketService.sendLocation(
          latitude: position.latitude,
          longitude: position.longitude,
          driverID: "driver1");
    });
  }

  Stream<Position> receiveLocationUpdates(driverID) {
    // _socketService.receiveLocation(driverID: "driverID").forEach((element) {
    //   print(element);
    // });
    return _socketService.receiveLocation(driverID: driverID);
  }

  Future<Position> receiveInitialLocation(driverID) async {
    return _socketService.receiveLocation(driverID: driverID).elementAt(0);
  }

  Stream<Position> livePosition() {
    Stream<Position> currentPosition = Geolocator.getPositionStream();
    sendLocationUpdates(currentPosition);
    // receiveLocationUpdates();
    return currentPosition;
  }
}
