import 'dart:convert';

Avoidance avoidanceFromJson(String str) => Avoidance.fromJson(json.decode(str));

String avoidanceToJson(Avoidance data) => json.encode(data.toJson());

class Avoidance {
  int? id;
  String? name;

  Avoidance({
    this.id,
    this.name,
  });

  factory Avoidance.fromJson(Map<String, dynamic> json) => Avoidance(
        id: json["id"],
        name: json["name"],
      );

  static List<Avoidance> fromJsonList(List<dynamic> jsonList) {
    List<Avoidance> toList = [];
    for (var item in jsonList) {
      Avoidance avoidance = Avoidance.fromJson(item);
      toList.add(avoidance);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
