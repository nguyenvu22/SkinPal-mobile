import 'dart:async';

import 'package:get/get.dart';
import 'package:skinpal/models/category.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/providers/categories_provider.dart';
import 'package:skinpal/providers/products_provider.dart';

class SearchController extends GetxController {
  var searchText = ''.obs;

  CategoriesProvider categoriesProvider = CategoriesProvider();
  ProductsProvider productsProvider = ProductsProvider();

  List<Category> categories = <Category>[].obs;

  Timer? searchRefreshing;

  SearchController() {
    getCategories();
  }

  void getCategories() async {
    var result = await categoriesProvider.getAllCategory();
    categories.clear();
    categories.addAll(result);
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
