import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/providers/routines_provider.dart';

class RoutineCreateController extends GetxController {
  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  var isNotify = false.obs;

  List<Map<String, Rx<dynamic>>> selectedDayInWeek = [
    {"dayInWeek": "Monday".obs, "isSelected": false.obs},
    {"dayInWeek": "Tuesday".obs, "isSelected": false.obs},
    {"dayInWeek": "Wednesday".obs, "isSelected": false.obs},
    {"dayInWeek": "Thursday".obs, "isSelected": false.obs},
    {"dayInWeek": "Friday".obs, "isSelected": false.obs},
    {"dayInWeek": "Saturday".obs, "isSelected": false.obs},
    {"dayInWeek": "Sunday".obs, "isSelected": false.obs},
  ];

  List<TimeOfDay> timeList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController step1Controller = TextEditingController();
  TextEditingController step2Controller = TextEditingController();
  TextEditingController step3Controller = TextEditingController();

  RoutinesProvider routinesProvider = RoutinesProvider();

  void createRoutine(schedules) async {
    if (nameController.text.isEmpty) {
      Get.snackbar(
        "Missing information!",
        "Please fill routine name.",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
    }

    List<String> dayOfWeeks = [];
    for (var element in selectedDayInWeek) {
      if (element['isSelected'] == true) {
        dayOfWeeks.add(element['dayInWeek'].toString());
      }
    }

    ResponseApi responseApi = await routinesProvider.createRoutine(
      nameController.text,
      schedules,
      dayOfWeeks.toString(),
    );
  }
}
