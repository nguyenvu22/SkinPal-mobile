import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/pages/store/cart/cart_controller.dart';
import 'package:skinpal/pages/store/search/search_controller.dart';
import 'package:skinpal/pages/store/store_controller.dart';
import 'package:skinpal/providers/products_provider.dart';

class ProductDetailController extends GetxController {
  Product product = Get.arguments['product'];
  bool fromCart = Get.arguments['fromCart'] ?? false;

  List<Product> productInCart = [];
  RxList<int> favoriteList = <int>[].obs;

  // Update item to cart
  CartController cartController = Get.find();
  // Update item quantity
  StoreController storeController = Get.find();
  SearchController searchController = Get.find();

  ProductsProvider productsProvider = ProductsProvider();

  ProductDetailController() {
    // if (GetStorage().read("shoppingCart") != null) {
    //   if (GetStorage().read("shoppingCart") is List<Product>) {
    //     // print("Get from storage LIST");
    //     productInCart = GetStorage().read("shoppingCart");
    //   } else {
    //     // print("Get from storage parse to LIST");
    //     productInCart = Product.fromJsonList(GetStorage().read("shoppingCart"));
    //   }
    // }
    if (GetStorage().read('favorite') != null) {
      favoriteList =
          (GetStorage().read('favorite') as List<dynamic>).cast<int>().obs;
    }
  }

  void favorite(int productId) {
    if (favoriteList.contains(productId)) {
      favoriteList.remove(productId);
    } else {
      favoriteList.add(productId);
    }
    GetStorage().write('favorite', favoriteList);
    searchController.favoriteList.value = favoriteList;
  }

  void updateFav() async {
    ResponseApi deleteApi = await productsProvider.deleteFavorite();
    if (deleteApi.success == true) {
      for (var idProduct in favoriteList) {
        ResponseApi addApi = await productsProvider.addFavorite(idProduct);
        if (addApi.success == false) {
          print("Add false");
          return;
        }
      }
    }
  }

  // Call in Page
  void checkProductInCart() {
    if (GetStorage().read("shoppingCart") != null) {
      if (GetStorage().read("shoppingCart") is List<Product>) {
        print("Get from storage LIST (Detail)");
        productInCart = GetStorage().read("shoppingCart");
      } else {
        print("Get from storage parse to LIST (Detail)");
        productInCart = Product.fromJsonList(GetStorage().read("shoppingCart"));
      }
    }
  }

  void addToCart() {
    int index = productInCart.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      // Product is not in cart yet
      product.quantity ??= 1;

      productInCart.add(product);
    } else {
      // Product is already in cart
      productInCart[index].quantity = productInCart[index].quantity! + 1;
    }

    GetStorage().write("shoppingCart", productInCart);
    // Since the list is list json type but we replace it with list product type
    // cartController.productInCart = productInCart;
    // Alternative : call again to update
    // cartController.initController();
    storeController.countItem(productInCart);

    Fluttertoast.showToast(
      msg: "+1 product to cart",
      backgroundColor: Colors.black,
      textColor: Colors.white,
      gravity: ToastGravity.TOP,
      fontSize: 20,
    );
  }
}
