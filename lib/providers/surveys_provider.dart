import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';

class SurveysProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api";

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List> getAllQues() async {
    Response response = await get(
      "$url/list-ans/skin-type",
      headers: {
        "Content-Type": "application/json",
      },
    );
    List result = [];
    for (var data in response.body) {
      result.add(data);
    }

    return result;
  }

  Future<List> getAllSkinType() async {
    Response response = await get(
      "$url/list/skin-type",
      headers: {
        "Content-Type": "application/json",
      },
    );
    List result = [];
    for (var data in response.body) {
      result.add(data);
    }
    return result;
  }

  Future<ResponseApi> updateUserSkinType(int idSkinType) async {
    Response response = await put(
      "$url/update/skin-type",
      {
        "idSkinType": idSkinType,
        "idUser": userSession.id,
      },
      headers: {
        "Content-Type": "application/json",
      },
    );
    ResponseApi responseApi = ResponseApi.fromJson(response.body);
    return responseApi;
  }
}
