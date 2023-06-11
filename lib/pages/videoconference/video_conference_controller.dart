import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/user.dart';

class VideoConferenceController extends GetxController {
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  
}
