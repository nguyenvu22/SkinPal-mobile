import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/store/store_controller.dart';

class CartController extends GetxController {
  // total price
  var totalPrice = 0.0.obs;
  var itemCounter = 0.obs;

  // update itemCounter value
  StoreController storeController = Get.find();

  // user cart
  List<Product> productInCart = <Product>[].obs;

  // CartController() {
  //   if (GetStorage().read("shoppingCart") != null) {
  //     if (GetStorage().read("shoppingCart") is List<Product>) {
  //       var result = GetStorage().read("shoppingCart");
  //       productInCart.clear();
  //       productInCart.addAll(result);
  //     } else {
  //       var result = Product.fromJsonList(GetStorage().read("shoppingCart"));
  //       productInCart.clear();
  //       productInCart.addAll(result);
  //     }
  //   }
  //   countTotal();
  // }

  void initController() {
    if (GetStorage().read("shoppingCart") != null) {
      if (GetStorage().read("shoppingCart") is List<Product>) {
        print("Get from storage LIST (Cart)");
        // var result = GetStorage().read("shoppingCart") as List<Product>;
        // productInCart.clear();
        // productInCart.addAll(result);
        productInCart = GetStorage().read("shoppingCart");
      } else {
        print("Get from storage parse to LIST (Cart)");
        var result = Product.fromJsonList(GetStorage().read("shoppingCart"));
        productInCart.clear();
        productInCart.addAll(result);
      }
    }
    countTotal();
  }

  void plusMoreItem(Product product) {
    // find where the product need to add in list
    int index = productInCart.indexWhere((p) => p.id == product.id);

    // // remove that product
    // productInCart.remove(product);
    // // that product quantity plus 1 more
    // product.quantity = product.quantity! + 1;
    // // add it back to the index with new quantity
    // productInCart.insert(index, product);

    product.quantity = product.quantity! + 1;
    productInCart[index] = product;

    // Update with new in4 to storage
    GetStorage().write("shoppingCart", productInCart);
    countTotal();
    storeController.countItem(productInCart);
    print("productInCart : $productInCart");
  }

  void minusLessItem(Product product) {
    if (product.quantity! > 1) {
      // find where the product need to add in list
      int index = productInCart.indexWhere((p) => p.id == product.id);

      // remove that product
      productInCart.remove(product);

      product.quantity = product.quantity! - 1;
      // add it back to the index with new quantity
      productInCart.insert(index, product);
    } else {
      productInCart.remove(product);
    }
    // Update with new in4 to storage
    GetStorage().write("shoppingCart", productInCart);
    countTotal();
    storeController.countItem(productInCart);
  }

  void removeToCart(Product product) {
    productInCart.remove(product);
    GetStorage().write('shoppingCart', productInCart);
    countTotal();
    storeController.countItem(productInCart);
  }

  void countTotal() {
    totalPrice.value = 0;
    for (var p in productInCart) {
      if (p.discount != 0) {
        totalPrice.value +=
            p.quantity! * (p.price! * ((100 - p.discount!) / 100));
      } else {
        totalPrice.value += p.quantity! * p.price!;
      }
    }
  }

  void goToProductDetail(Product product) {
    Get.toNamed("productDetail",
        arguments: {"product": product, "fromCart": true});
  }

  void goToCheckout() {
    Get.toNamed("/checkout");
  }
}
