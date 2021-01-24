class UserLink {
  final String link;

  UserLink({this.link});

  factory UserLink.fromJson(Map<String, dynamic> json) =>
      UserLink(link: json['link']);

  Map<String, dynamic> toJson() => {'link': link};

  @override
  String toString() {
    return 'UserLink{link: $link}';
  }
}
