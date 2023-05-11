import 'dart:convert';

Routine routineFromJson(String str) => Routine.fromJson(json.decode(str));

String routineToJson(Routine data) => json.encode(data.toJson());

class Routine {
  int? id;
  String? name;
  List<String>? schedules;
  List<String>? dayOfWeeks;
  List<String>? steps;
  int? idUser;

  Routine({
    this.id,
    this.name,
    this.schedules,
    this.dayOfWeeks,
    this.steps,
    this.idUser,
  });

  factory Routine.fromJson(Map<String, dynamic> jsonData) => Routine(
        id: jsonData["id"],
        name: jsonData["name"],
        // jsonData["schedules"] : response is String type and need to decode to be a list (if it already list)
        // Remember JSON type only allow "" but not ' '. If not => Parse all ' ' to "" to be a valid JSON String
        // schedules: List<String>.from(json.decode(jsonData["schedules"]) as List<dynamic>),
        // schedules: List<String>.from(
        //     json.decode(jsonData["schedules"].replaceAll("'", '"'))),
        schedules: List<String>.from(json.decode(jsonData["schedules"])),
        dayOfWeeks: List<String>.from(json.decode(jsonData["dayOfWeeks"])),
        steps: List<String>.from(json.decode(jsonData["steps"])),
        idUser: jsonData["idUser"],
      );

  static List<Routine> fromJsonList(List<dynamic> jsonList) {
    List<Routine> toList = [];
    for (var item in jsonList) {
      Routine routine = Routine.fromJson(item);
      toList.add(routine);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "schedules": List<dynamic>.from(schedules!.map((x) => x)),
        "dayOfWeeks": List<dynamic>.from(dayOfWeeks!.map((x) => x)),
        "steps": List<dynamic>.from(steps!.map((x) => x)),
        "idUser": idUser,
      };
}
