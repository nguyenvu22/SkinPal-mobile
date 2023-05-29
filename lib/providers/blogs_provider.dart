import 'package:get/get.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/blog.dart';

class BlogsProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/blogs";

  Future<List<Blog>> getAllBlog() async {
    Response response = await get(
      url,
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Blog> list = Blog.fromJsonList(response.body);
    return list;
  }
}
