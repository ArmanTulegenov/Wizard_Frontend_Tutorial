import 'package:web_socket_channel/io.dart';

import 'websocket_listener.dart';

class WebSocketServiceSingleton {
  static final String serviceEndPoint =
      'wss://hairstyle.javasoft.solutions/api/ws/';
  static List<WebSocketListener> listeners = [];

  static WebSocketServiceSingleton _instance = new WebSocketServiceSingleton._internal();
  static IOWebSocketChannel channel;

  factory WebSocketServiceSingleton() {
    return _instance;
  }

  WebSocketServiceSingleton._internal() {
    if (channel == null) {
      channel = IOWebSocketChannel.connect(serviceEndPoint,
          headers: {'Connection': 'upgrade', 'Upgrade': 'websocket'});
      channel.stream.listen((message) {
        for (final listener in listeners) {
          listener.onMessage(message);
        }
      });
      channel.sink.add("received!");    }
  }
  void addListener(WebSocketListener listener) {
    listeners.add(listener);
  }

}
