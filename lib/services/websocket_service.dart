import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  final _channel = WebSocketChannel.connect(
    Uri.parse("wss://echo.websocket.events"),
  );

  // to send the location of a driver to the server
  sendLocation({required latitude, required longitude, required driverID}) {
    _channel.sink.add("$latitude:$longitude:$driverID");
  }

  // to receive the location of a driver from the server
  Stream<dynamic> receiveLocation({required driverID}) {
    // _channel.sink.add("$driverID");
    return _channel.stream;
  }
}
