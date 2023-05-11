import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/models/user.dart';
import 'package:get_storage/get_storage.dart';

class RoutineCreateController extends GetxController {
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  var isNotify = false.obs;

  List<Map<String, Rx<dynamic>>> selectedDayInWeek = [
    {"dayInWeek": "M".obs, "isSelected": false.obs},
    {"dayInWeek": "T".obs, "isSelected": false.obs},
    {"dayInWeek": "W".obs, "isSelected": false.obs},
    {"dayInWeek": "T".obs, "isSelected": false.obs},
    {"dayInWeek": "F".obs, "isSelected": false.obs},
    {"dayInWeek": "S".obs, "isSelected": false.obs},
    {"dayInWeek": "S".obs, "isSelected": false.obs},
  ];

  List<TimeOfDay> timeList = [];

  TextEditingController nameController = TextEditingController();

  // RoutineCreateController() {}
}
