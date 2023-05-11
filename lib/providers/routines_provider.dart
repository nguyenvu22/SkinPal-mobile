import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/environment/environment.dart';
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
}
