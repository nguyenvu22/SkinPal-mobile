import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/user.dart';

class ProfileController extends GetxController {
  var userSession = User.fromJson(GetStorage().read('user') ?? {}).obs;
}
