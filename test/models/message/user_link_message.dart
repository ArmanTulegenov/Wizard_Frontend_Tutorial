import 'dart:convert';
import 'package:flutter_app/models/message/body/message_body.dart';
import 'package:flutter_app/models/message/message.dart';


void main() {

  String objText = '{"type": "UserLink", "body": {"link": "some_link"}}';
  String objText1 = '{"type": "UserDetails", "body": {"identity": "some_link", "password": "pass1"}}';

  // var bodyFactory = BodyFactory();
  // MessageUserLink messageUserLink = Function.apply(bodyFactory.factories()['MessageUserLink'], [objText]);
  // MessageUserLink messageUserLink = MessageUserLink.fromJson(jsonDecode(objText));
  print(Message.fromJson(jsonDecode(objText)));
  print(Message.fromJson(jsonDecode(objText)).toJson());
  print(Message.fromJson(jsonDecode(objText1)));
  print(Message.fromJson(jsonDecode(objText1)).toJson());
}