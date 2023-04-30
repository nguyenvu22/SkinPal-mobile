import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:skinpal/pages/store/user/routine/list/routine_list_controller.dart';

class RoutineListPage extends StatefulWidget {
  RoutineListPage({super.key});

  RoutineListController con = Get.put(RoutineListController());

  @override
  State<RoutineListPage> createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
