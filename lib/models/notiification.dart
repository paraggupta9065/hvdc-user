import 'dart:convert';

UserNotification notificationFromJson(String str) =>
    UserNotification.fromJson(json.decode(str));

String notificationToJson(UserNotification data) => json.encode(data.toJson());

class UserNotification {
  int id;
  String title;
  String description;
  String type;
  String typeId;
  int user;

  UserNotification({
    required this.id,
    required this.title,
    required this.description,
    required this.type,
    required this.typeId,
    required this.user,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) =>
      UserNotification(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        type: json["type"],
        typeId: json["type_id"],
        user: json["user"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "type": type,
        "type_id": typeId,
        "user": user,
      };
}
