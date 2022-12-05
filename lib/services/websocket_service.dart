import 'package:geolocator/geolocator.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:io';

class WebSocketService {
  final _channel = WebSocketChannel.connect(
      Uri.parse("wss://mudrika-websocket-server.ajayk-01.repl.co"));

  // to send the location of a driver to the server
  sendLocation({required latitude, required longitude, required driverID}) {
    _channel.sink.add("update:$driverID:$latitude:$longitude");
  }

  // to receive the location of a driver from the server
  Stream<Position> receiveLocation({required driverID}) {
    _channel.sink.add("get:$driverID");

    return _channel.stream.asyncMap((locString) {
      var splitString = locString.split(":");
      Position recvPosition = Position(
          latitude: double.parse(splitString[1]),
          longitude: double.parse(splitString[2]),
          timestamp: null,
          accuracy: 0,
          altitude: 0,
          heading: 0,
          speed: 0,
          speedAccuracy: 0);

      sleep(const Duration(seconds: 1));
      _channel.sink.add("get:$driverID");

      return recvPosition;
    });
  }
}
