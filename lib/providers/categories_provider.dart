import 'package:get/get.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/category.dart';

class CategoriesProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/categories";

  Future<List<Category>> getAllCategory() async {
    Response response = await get(
      "$url/allCategory",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Category> listData = Category.fromJsonList(response.body);
    return listData;
  }
}
