import 'package:flutter_app/models/message/message.dart';

import 'body/user_link.dart';

class MessageUserLink extends Message<UserLink> {
  String type;
  UserLink body;

  MessageUserLink({String type, UserLink body}) : super(type: type, body: body) {
    this.type = type;
    this.body = body;
  }

  factory MessageUserLink.fromJson(Map<String, dynamic> json) =>
      MessageUserLink(type: json['type'], body: UserLink.fromJson(json['body']));

  Map<String, dynamic> toJson() => {'type': type, 'body': body};

  @override
  String toString() {
    return 'MessageUserLink{type: $type, body: $body}';
  }
}
