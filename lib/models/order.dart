import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  int? id;
  int? status;
  double? totalPrice;
  String? address;
  String? phone;
  int? idUser;

  Order({
    this.id,
    this.status,
    this.totalPrice,
    this.address,
    this.phone,
    this.idUser,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        status: json["status"],
        totalPrice: json["totalPrice"].toDouble(),
        address: json["address"],
        phone: json["phone"],
        idUser: json["idUser"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "totalPrice": totalPrice,
        "address": address,
        "phone": phone,
        "idUser": idUser,
      };
}
