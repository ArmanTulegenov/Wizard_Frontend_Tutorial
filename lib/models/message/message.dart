class Message<T> {
  String type;
  T body;
  Message ({this.type, this.body});

  factory Message.fromJson(Map<String, dynamic> json) => Message(type: json['type'], body: json['body']);

  Map<String, dynamic> toJson() => {
    'type': type,
    'body': body
  };

}