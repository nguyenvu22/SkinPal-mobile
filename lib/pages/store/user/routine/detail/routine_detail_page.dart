import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/pages/store/user/routine/detail/routine_detail_controller.dart';

class RoutineDetailPage extends StatelessWidget {
  RoutineDetailPage({super.key});

  RoutineDetailController con = Get.put(RoutineDetailController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
