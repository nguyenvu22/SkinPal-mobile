import 'package:get/get.dart';
import 'package:skinpal/models/blog.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/providers/blogs_provider.dart';
import 'package:skinpal/providers/products_provider.dart';

class HomeController extends GetxController {
  BlogsProvider blogsProvider = BlogsProvider();
  ProductsProvider productsProvider = ProductsProvider();

  Future<List<Blog>> getAllBlog() async {
    return await blogsProvider.getAllBlog();
  }

  Future<List<Product>> getProductsWithAll() async {
    return await productsProvider.getAllProduct();
  }
}
