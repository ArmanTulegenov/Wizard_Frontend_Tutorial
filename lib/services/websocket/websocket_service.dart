import 'dart:collection';
import 'dart:convert';

import 'package:web_socket_channel/io.dart';

import '../../models/message/message.dart';
import '../../services/websocket/websocket_listener.dart';

class WebSocketService {
  static final String serviceEndPoint =
      'wss://hairstyle.javasoft.solutions/api/ws/';

  static final WebSocketService _instance = WebSocketService._internal();
  IOWebSocketChannel _channel;
  Map<String, List<WebSocketListener>> listeners = new HashMap();


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
      Message msg = json.decode(message);
      for (var listener in listeners[msg.type]) {
        listener.onMessage(message);
      }
    });
  }

  Future<void> doLogin(String login, String password) async {
    _channel.sink.add('login $login $password');
  }

  Future<void> doRegistrationOrRestore(String login) async {
    _channel.sink.add('register $login');
  }

  void addListener(WebSocketListener listener) {
    var messageType = listener.getMessageType();
    if (listeners.containsKey(messageType)) {
      List<WebSocketListener> existingListeners = listeners[messageType];
      existingListeners.add(listener);
      listeners.update(messageType, (value) => existingListeners);
    } else {
      List<WebSocketListener> newListeners = [];
      newListeners.add(listener);
      listeners.putIfAbsent(messageType, () => newListeners);
    }
  }
}