import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/environment/environment.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/routine.dart';
import 'package:skinpal/models/user.dart';

class RoutinesProvider extends GetConnect {
  String url = "${Environment.GETX_API_URL}api/routines";

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  Future<List<Routine>> getAllRoutine() async {
    Response response = await get(
      "$url/allRoutineOfUser/${userSession.id}",
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.body == null) {
      return [];
    }
    List<Routine> listData = Routine.fromJsonList(response.body['data']);
    return listData;
  }

  Future<ResponseApi> createRoutine(String name, String schedules, String dayOfWeeks) async {
    Response response = await post(
      "$url/create",
      {
        "name": name,
        "schedules": schedules,
        "dayOfWeeks": dayOfWeeks,
        "steps": "",
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
