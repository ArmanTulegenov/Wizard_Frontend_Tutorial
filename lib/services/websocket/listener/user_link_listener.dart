import 'package:flutter_app/models/message/body/user_link_body.dart';
import 'package:flutter_app/models/message/message.dart';
import 'package:flutter_app/services/websocket/listener/websocket_listener.dart';

class UserLinkListener extends WebSocketListener<UserLinkBody> {

  UserLinkListener(){}

  @override
  String getMessageType() {
    return 'UserLink';
  }

  @override
  void onMessage(Message<UserLinkBody> message) {
    print(message);
  }

}