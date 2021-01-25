import 'dart:convert';
import 'package:flutter_app/models/message/body/user_link_body.dart';
import 'package:flutter_app/models/message/body/user_details_body.dart';

class BodyFactory {
  static Function getUserLinkFactory = (json) => UserLinkBody.fromJson(json);
  static Function getUserDetailsFactory = (json) => UserDetailsBody.fromJson(json);

  Map<String, Function> factories() => {
    'UserLink':  BodyFactory.getUserLinkFactory,
    'UserDetails':  BodyFactory.getUserDetailsFactory,

  };


}

