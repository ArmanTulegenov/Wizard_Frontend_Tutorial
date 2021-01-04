import 'package:web_socket_channel/io.dart';

import 'websocket_listener.dart';

class WebSocketServiceSingleton {
  static final String serviceEndPoint =
      'wss://hairstyle.javasoft.solutions/api/ws/';
  static List<WebSocketListener> listeners = [];

  static WebSocketServiceSingleton _instance;

  WebSocketServiceSingleton._internal();

  factory WebSocketServiceSingleton()=> instance;

  static WebSocketServiceSingleton get instance {
    if (_instance != null) {
      return _instance;
    }
    _instance = new WebSocketServiceSingleton._internal();

    final IOWebSocketChannel _channel = IOWebSocketChannel.connect(
        serviceEndPoint,
        headers: {'Connection': 'upgrade', 'Upgrade': 'websocket'});
    _channel.stream.listen((message) {
      print("Hello from singleton");
      for (final listener in listeners) {
        listener.onMessage(message);
      }
    });
    _channel.sink.add("received!");
    return _instance;
  }

  void addListener(WebSocketListener listener) {
    listeners.add(listener);
  }
}
