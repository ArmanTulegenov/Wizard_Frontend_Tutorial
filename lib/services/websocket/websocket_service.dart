import 'package:web_socket_channel/io.dart';

import '../../services/websocket/websocket_listener.dart';

class WebSocketService {
  static final String serviceEndPoint =
      'wss://hairstyle.javasoft.solutions/api/ws/';

  static final WebSocketService _instance = WebSocketService._internal();
  IOWebSocketChannel _channel;
  List<WebSocketListener> listeners = [];

  factory WebSocketService() {
    return _instance;
  }

  WebSocketService._internal() {
    initChannel();
  }

  Future<void> initChannel() async {
    _channel = IOWebSocketChannel.connect(serviceEndPoint,
        headers: {'Connection': 'upgrade', 'Upgrade': 'websocket'});
    _channel.stream.listen((message) {
      for (final listener in listeners) {
        listener.onMessage(message);
      }
    });
  }

  Future<void> doLogin(String login, String password) async {
    _channel.sink.add('login $login $password');
  }

  Future<void> doRegistration(String login) async {
    _channel.sink.add('register $login');
  }

  void addListener(WebSocketListener listener) {
    listeners.add(listener);
  }
}
