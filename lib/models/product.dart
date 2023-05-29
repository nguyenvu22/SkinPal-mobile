import 'dart:convert';

import 'package:skinpal/models/avoidance.dart';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  int? id;
  String? name;
  String? image;
  String? description;
  double? price;
  // An object
  dynamic instruction;
  int? discount;
  // An list object
  List<Avoidance>? avoidance = [];
  int? favorite;
  int? quantity;

  Product({
    this.id,
    this.name,
    this.image,
    this.description,
    this.price,
    this.instruction,
    this.discount,
    this.avoidance,
    this.favorite,
    this.quantity,
  });

  factory Product.fromJson(Map<String, dynamic> jsonData) => Product(
        id: jsonData["id"],
        name: jsonData["name"],
        image: jsonData["image"],
        description: jsonData["description"],
        price: jsonData["price"].toDouble(),
        // instruction: jsonData["instruction"],
        //parse to dynamic obj -> usable ( response's type is String )
        // instruction: jsonData["instruction"] == null
        //     ? {}
        //     : json.decode(jsonData["instruction"]),
        instruction:
            jsonData["instruction"] != null && jsonData["instruction"] is String
                ? json.decode(jsonData["instruction"])
                : jsonData["instruction"],
        discount: jsonData["discount"],
        avoidance: jsonData["avoidance"] != null
            ? jsonData["avoidance"] is String
                ? List<Avoidance>.from(json.decode(jsonData["avoidance"]).map(
                    (model) =>
                        model is Avoidance ? model : Avoidance.fromJson(model)))
                : List<Avoidance>.from(jsonData["avoidance"].map((model) =>
                    model is Avoidance ? model : Avoidance.fromJson(model)))
            : [],
        favorite: jsonData["favorite"] ?? 0,
        quantity: jsonData["quantity"],
      );

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    List<Product> toList = [];
    for (var item in jsonList) {
      Product product = Product.fromJson(item);
      toList.add(product);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "description": description,
        "price": price,
        "instruction": instruction,
        "discount": discount,
        "avoidance": List<dynamic>.from(avoidance!.map((x) => x)),
        "favorite": favorite,
        "quantity": quantity,
      };
}
