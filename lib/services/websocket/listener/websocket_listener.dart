import '../../../models/message/message.dart';

abstract class WebSocketListener<T> {
  String getMessageType();
  void onMessage(Message<T> message);
}