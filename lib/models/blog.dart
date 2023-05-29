import 'dart:convert';

Blog blogFromJson(String str) => Blog.fromJson(json.decode(str));

String blogToJson(Blog data) => json.encode(data.toJson());

class Blog {
  int? id;
  String? image;
  String? description;
  String? title;

  Blog({
    this.id,
    this.image,
    this.description,
    this.title,
  });

  factory Blog.fromJson(Map<String, dynamic> json) => Blog(
        id: json["id"],
        image: json["image"],
        description: json["description"],
        title: json["title"],
      );

  static List<Blog> fromJsonList(List<dynamic> jsonList) {
    List<Blog> toList = [];
    for (var item in jsonList) {
      Blog blog = Blog.fromJson(item);
      toList.add(blog);
    }
    return toList;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "description": description,
        "title": title,
      };
}
