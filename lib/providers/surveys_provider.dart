import 'package:get/get.dart';
import 'package:skinpal/environment/environment.dart';

class SurveysProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/skin-type";

  Future<List> getAllQues() async {
    Response response = await get(
      "$url/list-ans",
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
      "$url/list",
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

  
}
