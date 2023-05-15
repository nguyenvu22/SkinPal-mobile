import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/providers/products_provider.dart';

class FavoriteController extends GetxController {
  ProductsProvider productsProvider = ProductsProvider();

  // {"productId": 1, "isLike": true}
  List<Map<String, dynamic>> listFavorite = [];

  Future<List<Product>> getFavoriteProducts() async {
    return await productsProvider.getAllFavorite();
  }

  void addFavorite(int idProduct) async {
    ResponseApi responseApi = await productsProvider.addFavorite(idProduct);
    if(responseApi.success == false){

    }
  }

  void cutFavorite(int idProduct) async {
    ResponseApi responseApi = await productsProvider.cutFavorite(idProduct);
    if(responseApi.success == false){
      
    }
  }
}
