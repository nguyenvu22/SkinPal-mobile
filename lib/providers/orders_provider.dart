import 'package:get/get.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/order.dart';
import 'package:skinpal/models/response_api.dart';

class OrdersProvider extends GetConnect {
  String url_order = "${Environment.GETX_API_URL}api/orders";
  String url_order_detail = "${Environment.GETX_API_URL}api/order_details";

  Future<ResponseApi> createOrder(Order order) async {
    print("order : ${order.toJson()}");
    Response response = await post(
      "$url_order/create",
      order.toJson(),
      headers: {
        "Content-Type": "application/json",
      },
    );
    print("res order : ${response.body}");
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    print("res Api: ${responseApi.toJson()}");
    return responseApi;
  }

  Future<ResponseApi> createOrderDetail(
      int idOrder, int idProduct, int quantity) async {
    Response response = await post(
      "$url_order/create",
      {
        "idOrder": idOrder,
        "idProduct": idProduct,
        "quantity": quantity,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
