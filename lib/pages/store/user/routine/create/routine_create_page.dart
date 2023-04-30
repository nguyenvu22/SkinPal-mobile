import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skinpal/pages/store/user/routine/create/routine_create_controller.dart';

class RoutineCreatePage extends StatefulWidget {
  RoutineCreatePage({super.key});

  RoutineCreateController con = Get.put(RoutineCreateController());

  @override
  State<RoutineCreatePage> createState() => _RoutineCreatePageState();
}

class _RoutineCreatePageState extends State<RoutineCreatePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(),
      ),
    );
  }
}
