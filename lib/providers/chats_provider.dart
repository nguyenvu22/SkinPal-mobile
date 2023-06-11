import 'package:get/get.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/response_api.dart';

class ChatsProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/chat-gpt";

  Future<ResponseApi> sendMessage(String mess) async {
    Response response = await post(
      "$url",
      {
        "message": mess,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return ResponseApi(
        success: false,
        message: "Sorry! We can not answer this question yet.",
      );
    }
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
