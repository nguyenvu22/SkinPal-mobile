import 'package:get/get.dart';
import 'package:intl/intl.dart';

class RoutineListController extends GetxController {
  String? todayWeekly;

  RoutineListController(){
    DateTime now = DateTime.now();
    todayWeekly = DateFormat('EEEE').format(now);
  }
}
