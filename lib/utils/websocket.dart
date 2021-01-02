import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'websocket_listener.dart';

class WebSocketServiceSingleton {

  static final String serviceEndPoint = 'wss://hairstyle.javasoft.solutions/api/ws/';
  static List<WebSocketListener> listeners;

  static WebSocketServiceSingleton _instance;
  static IOWebSocketChannel channel;

  static WebSocketServiceSingleton get instance {
    if (_instance == null) {
      _instance = new WebSocketServiceSingleton()._();
    }
    return _instance;
  }
  _() {
    listeners = new List();
    connect();
  }
  factory WebSocketServiceSingleton() => instance;

  void addListener(WebSocketListener listener) {
    listeners.add(listener);
  }

  void connect () {
    channel = IOWebSocketChannel.connect(serviceEndPoint,  headers: {'Connection': 'upgrade', 'Upgrade': 'websocket'});
    channel.stream.listen((message) {
      for (final listener in listeners) {
        listener.onMessage(message);
      }
    });
  }
}
