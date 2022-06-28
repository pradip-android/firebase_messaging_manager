class Notification {
  Notification({this.body, this.title, this.type, this.id});

  String? body;
  String? title;
  String? type;
  dynamic id;

  factory Notification.fromJson(Map<String, dynamic> json) =>
      Notification(body: json["body"], title: json["title"], type: json["type"], id: json["id"]);

  Map<String, dynamic> toJson() => {"body": body, "title": title, "type": type, "id": id};
}
