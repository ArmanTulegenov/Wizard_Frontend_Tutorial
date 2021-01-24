import '../../models/message/message.dart';

abstract class WebSocketListener {
  String getMessageType();
  void onMessage(Message message);
}