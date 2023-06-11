import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/pages/store/search/search_controller.dart';
import 'package:skinpal/providers/products_provider.dart';
import 'package:get/get.dart';

class FavoriteController extends GetxController {
  ProductsProvider productsProvider = ProductsProvider();

  // {"productId": 1, "isLike": true}
  RxList<Product> productList = <Product>[].obs;
  RxList<int> favoriteList = <int>[].obs;

  SearchController searchController = Get.find();

  FavoriteController() {
    if (GetStorage().read('favorite') != null) {
      favoriteList =
          (GetStorage().read('favorite') as List<dynamic>).cast<int>().obs;
    }
    getFavoriteProducts();
  }

  void favorite(int productId) {
    if (favoriteList.contains(productId)) {
      favoriteList.remove(productId);
    } else {
      favoriteList.add(productId);
    }
    GetStorage().write('favorite', favoriteList);
  }

  void getFavoriteProducts() async {
    productList.value = await productsProvider.getAllFavorite();
  }

  void deleteFromFavorite(int idProduct) async {
    //remove from ui
    productList.removeWhere((product) => product.id == idProduct);

    //remove from fav list
    favoriteList.remove(idProduct);
    GetStorage().write('favorite', favoriteList);

    searchController.favoriteList.value = favoriteList;

    //remove in db
    ResponseApi responseApi =
        await productsProvider.deleteSpecificFavorite(idProduct);
    if (responseApi.success == false) {}
  }
}
