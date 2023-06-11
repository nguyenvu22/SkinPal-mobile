import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/category.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/store/store_controller.dart';
import 'package:skinpal/providers/categories_provider.dart';
import 'package:skinpal/providers/products_provider.dart';

class SearchController extends GetxController {
  var searchText = ''.obs;

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  StoreController storeController = Get.find();

  List<Category> categories = <Category>[].obs;
  List<Product> productInCart = [];
  RxList<int> favoriteList = <int>[].obs;

  Timer? searchRefreshing;

  SearchController() {
    getCategories();
    if (GetStorage().read("shoppingCart") != null) {
      if (GetStorage().read("shoppingCart") is List<Product>) {
        print("Get from storage LIST (Detail)");
        productInCart = GetStorage().read("shoppingCart");
      } else {
        print("Get from storage parse to LIST (Detail)");
        productInCart = Product.fromJsonList(GetStorage().read("shoppingCart"));
      }
    }
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
  }

  void getCategories() async {
    var result = await categoriesProvider.getAllCategory();
    categories.clear();
    categories.addAll(result);
  }

  void addToCart(Product product) {
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

  // bring data to FutureBuilder
  Future<List<Product>> getProductsWithAll(String search) async {
    if (search.isEmpty) {
      return await productsProvider.getAllProduct();
    } else {
      return await productsProvider.searchAllProduct(search);
    }
  }

  // bring data to FutureBuilder
  Future<List<Product>> getProductsWithCate(
      int idCategory, String search) async {
    if (search.isEmpty) {
      return await productsProvider.getAllProductWithCate(idCategory);
    } else {
      return await productsProvider.getAllProductWithCateAndSearch(
          idCategory, search);
    }
  }

  void onTextChanging(String text) {
    const duration = Duration(milliseconds: 1000);
    if (searchRefreshing != null) {
      searchRefreshing?.cancel();
    }

    searchRefreshing = Timer(duration, () {
      searchText.value = text;
    });
  }

  void goToProductDetail(Product product) {
    Get.toNamed("/productDetail", arguments: {"product": product});
  }
}
