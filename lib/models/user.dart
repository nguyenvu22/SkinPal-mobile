import 'dart:convert';

User productFromJson(String str) => User.fromJson(json.decode(str));

String productToJson(User data) => json.encode(data.toJson());

class User {
  int? id;
  String? name;
  String? email;
  String? password;
  String? dob;
  String? avatar;
  String? membership;
  bool? isStudent;
  String? studentIdentificationImg;
  bool? isPremium;
  String? startPremium;
  String? endPremium;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.dob,
    this.avatar,
    this.membership,
    this.isStudent,
    this.studentIdentificationImg,
    this.isPremium,
    this.startPremium,
    this.endPremium,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        password: json["password"],
        dob: json["dob"],
        avatar: json["avatar"],
        membership: json["membership"],
        isStudent: json["isStudent"],
        studentIdentificationImg: json["studentIdentificationImg"],
        isPremium: json["isPremium"] != null
            ? json["isPremium"] == 1
                ? true
                : false
            : json["isPremium"],
        startPremium: json["startPremium"],
        endPremium: json["endPremium"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "password": password,
        "dob": dob,
        "avatar": avatar,
        "membership": membership,
        "isStudent": isStudent,
        "studentIdentificationImg": studentIdentificationImg,
        "isPremium": isPremium,
        "startPremium": startPremium,
        "endPremium": endPremium,
      };
}
