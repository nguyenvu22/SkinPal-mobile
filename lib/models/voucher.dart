import 'dart:convert';

Voucher voucherFromJson(String str) => Voucher.fromJson(json.decode(str));

String voucherToJson(Voucher data) => json.encode(data.toJson());

class Voucher {
  int? id;
  String? name;
  int? condition;
  String? image;
  bool? isUsed;
  int? discount;
  DateTime? startDate;
  DateTime? endDate;
  bool? qualify;

  Voucher({
    this.id,
    this.name,
    this.condition,
    this.image,
    this.isUsed,
    this.discount,
    this.qualify,
    this.startDate,
    this.endDate,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
        id: json["id"],
        name: json["name"],
        condition: json["condition"],
        image: json["image"],
        isUsed: json["isUsed"] == 0 ? false : true,
        discount: json["discount"],
        startDate: DateTime.parse(json["startDate"]),
        endDate: DateTime.parse(json["endDate"]),
        qualify: json["qualify"],
      );

  static List<Voucher> fromJsonList(List<dynamic> jsonList) {
    List<Voucher> toList = [];
    for (var item in jsonList) {
      Voucher voucher = Voucher.fromJson(item);
      toList.add(voucher);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "condition": condition,
        "image": image,
        "isUsed": isUsed,
        "discount": discount,
        "startDate": startDate,
        "endDate": endDate,
        "qualify": qualify,
      };
}
