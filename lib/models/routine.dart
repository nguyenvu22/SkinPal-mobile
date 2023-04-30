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

    factory Routine.fromJson(Map<String, dynamic> json) => Routine(
        id: json["id"],
        name: json["name"],
        schedules: List<String>.from(json["schedules"].map((x) => x)),
        dayOfWeeks: List<String>.from(json["dayOfWeeks"].map((x) => x)),
        steps: List<String>.from(json["steps"].map((x) => x)),
        idUser: json["idUser"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "schedules": List<dynamic>.from(schedules!.map((x) => x)),
        "dayOfWeeks": List<dynamic>.from(dayOfWeeks!.map((x) => x)),
        "steps": List<dynamic>.from(steps!.map((x) => x)),
        "idUser": idUser,
    };
}