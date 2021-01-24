import 'dart:convert';
import 'package:flutter_app/models/message/user_link_message.dart';


void main() {

  String objText = '{"type": "SomeType", "body": {"link": "some_link"}}';
  MessageUserLink messageUserLink = MessageUserLink.fromJson(jsonDecode(objText));
  print(messageUserLink);
}