import 'message_body.dart';

class UserLinkBody extends MessageBody {
  final String link;

  UserLinkBody({this.link});

  factory UserLinkBody.fromJson(Map<String, dynamic> json) =>
      UserLinkBody(link: json['link']);

  Map<String, dynamic> toJson() => {'link': link};

  @override
  String toString() {
    return 'UserLinkBody{link: $link}';
  }
}
