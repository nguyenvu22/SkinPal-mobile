import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  int? id;
  String? name;

  Category({
    this.id,
    this.name,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
      );

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    List<Category> toList = [];
    for (var item in jsonList) {
      Category category = Category.fromJson(item);
      toList.add(category);
    }
    return toList;
  }
  // static List<Category> fromJsonList(List<dynamic> jsonList) {
  //   List<Category> toList = [];
  //   jsonList.forEach((item) {
  //     Category category = Category.fromJson(item);
  //     toList.add(category);
  //   });
  //   return toList;
  // }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
