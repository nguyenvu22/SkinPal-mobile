import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:skinpal/models/routine.dart';
import 'package:skinpal/models/user.dart';
import 'package:skinpal/pages/store/user/routine/create/routine_create_page.dart';
import 'package:skinpal/providers/routines_provider.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart' as modal;

class RoutineListController extends GetxController {
  DateTime? currentDay;
  String? currentMonth;
  String? todayWeekly;
  List<String> weekDates = [];

  RoutinesProvider routinesProvider = RoutinesProvider();

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  RoutineListController() {
    // // Get Date - Month - Week at Current day
    // currentDay = DateTime.now();
    // currentMonth = DateFormat("MMM").format(currentDay!);
    // todayWeekly = DateFormat('EEEE').format(currentDay!);
  }

  void initController() {
    // Get Date - Month - Week at Current day
    currentDay = DateTime.now();
    // print("currentDay: ${currentDay.toString()}");
    currentMonth = DateFormat("MMM").format(currentDay!);
    // print("currentMonth: ${currentMonth.toString()}");
    todayWeekly = DateFormat('EEEE').format(currentDay!);
    // print("todayWeekly: ${todayWeekly.toString()}");

    //-------------------------------------------------------------------------------

    // Get the current day of the week (Monday is 1, Sunday is 7)
    int currentWeekday = currentDay!.weekday;

    // Subtract days to get to the start of the week (i.e. Monday)  =>  (if currentWeekday is 4 => minus 3 to be monday)
    DateTime startOfWeek =
        currentDay!.subtract(Duration(days: currentWeekday - 1));
    // Add six days to get to the end of the week (i.e. Sunday)  =>   (plus 6 days more to make whole week)
    DateTime endOfWeek = startOfWeek.add(const Duration(days: 6));

    // // Adjust the start and end dates to include the days before and after the current day to make up a full week
    // if (currentWeekday != 1) {
    //   // Start week is not Monday
    //   startOfWeek = startOfWeek.subtract(Duration(days: currentWeekday - 1));
    // }
    // if (currentWeekday != 7) {
    //   // End week day is not Sunday
    //   endOfWeek = endOfWeek.add(Duration(days: 7 - currentWeekday));
    // }

    weekDates.clear();
    for (int i = 0; i < 7; i++) {
      DateTime currentDate = startOfWeek.add(Duration(days: i));
      String dayOfMonth = DateFormat('dd').format(currentDate);
      weekDates.add(dayOfMonth);
    }

    print("weekDates: ${weekDates.toString()}");
    //-------------------------------------------------------------------------------
  }

  Future<List<Routine>> getRoutine(String week) async {
    List<Routine> resultList = [];

    List<Routine> listRoutine = await routinesProvider.getAllRoutine();
    // Optimize
    resultList.addAll(
        listRoutine.where((routine) => routine.dayOfWeeks!.contains(week)));
    // resultList.forEach((element) {
    //   print("resultList : ${element.toJson()}");
    // });
    return resultList;
  }

  void goToCreateRoutine() {
    // modal.showMaterialModalBottomSheet(
    //   context: context,
    //   isDismissible: false, // Prevent closing by tapping outside the modal
    //   enableDrag: false, // Prevent closing by dragging down
    //   builder: (context) => RoutineCreatePage(),
    // );
    Get.toNamed("/routineCreate");
  }
}
