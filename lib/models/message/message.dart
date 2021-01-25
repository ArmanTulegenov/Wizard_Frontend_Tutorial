import 'body/message_body.dart';
import 'body/body_factory.dart';

class Message<T> {
  String type;
  MessageBody<T> body;

  Message ({this.type, this.body});

  factory Message.fromJson(Map<String, dynamic> json) {
    String messageType = json['type'];
    var bodyFactory = BodyFactory();
    return Message(type: messageType, body: Function.apply(bodyFactory.factories()[messageType], [json['body']]));
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'body': body.toJson()
  };

  @override
  String toString() {
    return 'Message{type: $type, body: $body}';
  }
}