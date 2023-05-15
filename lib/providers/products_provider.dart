import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';

class ProductsProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/products";

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Product>> getAllProduct() async {
    Response response = await get(
      "$url/allProducts/${userSession.id}",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Product> listData = Product.fromJsonList(response.body);
    return listData;
  }

  Future<List<Product>> searchAllProduct(String name) async {
    Response response = await get(
      "$url/allProducts/name/${userSession.id}/$name",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null || response.body == []) {
      return [];
    }
    List<Product> listData = Product.fromJsonList(response.body);
    return listData;
  }

  Future<List<Product>> getAllProductWithCate(int idCate) async {
    Response response = await get(
      "$url/allProducts/cate/${userSession.id}/$idCate",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Product> listData = Product.fromJsonList(response.body);
    return listData;
  }

  Future<List<Product>> getAllProductWithCateAndSearch(
      int idCate, String search) async {
    Response response = await get(
      "$url/allProducts/${userSession.id}/$idCate/$search",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Product> listData = Product.fromJsonList(response.body);
    return listData;
  }

  Future<List<Product>> getAllFavorite() async {
    Response response = await get(
      "$url/favoriteProducts/${userSession.id}",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Product> listData = Product.fromJsonList(response.body);
    return listData;
  }

  Future<ResponseApi> addFavorite(int idProduct) async {
    Response response = await post(
      "$url/favoriteAdditional",
      {
        "idUser": userSession.id,
        "idProduct": idProduct,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }

  Future<ResponseApi> cutFavorite(int idProduct) async {
    Response response = await put(
      "$url/productModification",
      {
        "idUser": userSession.id,
        "idProduct": idProduct,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("response : ${response.body}");
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
