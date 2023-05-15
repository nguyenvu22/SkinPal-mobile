import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/models/user.dart';

class StoreController extends GetxController {
  User user = User.fromJson(GetStorage().read('user') ?? {});

  // list product in cart
  List<Product> productInCart = [];

  // total item in cart
  var itemCounter = 0.obs;

  StoreController() {
    if (GetStorage().read('shoppingCart') != null) {
      if (GetStorage().read('shoppingCart') is List<Product>) {
        productInCart = GetStorage().read('shoppingCart');
      } else {
        productInCart = Product.fromJsonList(GetStorage().read('shoppingCart'));
      }
      countItem(productInCart);
    }
  }

  void countItem(List<Product> pList) {
    itemCounter.value = 0;
    for (var p in pList) {
      itemCounter.value += p.quantity!;
    }
  }
}
