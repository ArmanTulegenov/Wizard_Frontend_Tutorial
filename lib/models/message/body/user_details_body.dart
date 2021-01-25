import 'message_body.dart';

class UserDetailsBody extends MessageBody {
  final String identity;
  final String password;

  UserDetailsBody({this.identity, this.password});

  factory UserDetailsBody.fromJson(Map<String, dynamic> json) =>
      UserDetailsBody(identity: json['identity'], password: json['password']);

  Map<String, dynamic> toJson() => {'identity': identity, 'password': password};

  @override
  String toString() {
    return 'UserDetailsBody{identity: $identity, password: $password}';
  }
}
