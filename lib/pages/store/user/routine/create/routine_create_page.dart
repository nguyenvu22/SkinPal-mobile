import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/store/user/routine/create/routine_create_controller.dart';
import 'package:intl/intl.dart';

class RoutineCreatePage extends StatefulWidget {
  RoutineCreatePage({super.key});

  RoutineCreateController con = Get.put(RoutineCreateController());

  @override
  State<RoutineCreatePage> createState() => _RoutineCreatePageState();
}

class _RoutineCreatePageState extends State<RoutineCreatePage> {
  DateTime now = DateTime.now();
  final timeWidgets = <Widget>[].obs;

  void _addNewTimeWidget() {
    TimeOfDay _time = TimeOfDay(hour: 12, minute: 20);
    timeWidgets.add(
      Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          // color: Colors.amberAccent,
          border: Border.all(
            width: 1,
            color: AppColor.inactiveColor,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          color: Colors.amberAccent,
          child: ElevatedButton(
            style: ButtonStyle(

            ),
            child: Text(
              "00:01",
              // "${_time.hour.toString()} : ${_time.minute.toString()}",
              style: TextStyle(
                color: AppColor.inactiveColor,
              ),
            ),
            onPressed: () async {
              // TimeOfDay? newTime = await showTimePicker(
              //   context: context,
              //   initialTime: _time,
              // );
              // print("newTime: ${newTime}");
              // if (newTime != null) {
              //   setState(() {
              //     _time = newTime;
              //   });
              // }
              showTimePicker(
                context: context,
                initialTime: _time,
              ).then((value) {
                setState(() {
                  _time = value!;
                });
              });
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // _addNewTimeWidget();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              _topSection(w, h),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: double.infinity,
                  height: h * 0.35,
                  color: AppColor.routineColor,
                  child: Column(
                    children: [
                      const Expanded(
                        child: SizedBox(),
                      ),
                      Container(
                        width: w * 0.7,
                        height: 40,
                        alignment: Alignment.bottomCenter,
                        margin: EdgeInsets.only(bottom: h * 0.035),
                        // color: Colors.amberAccent,
                        child: _botSection(),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: h * 0.28,
                right: 0,
                child: SizedBox(
                  // width: w * 0.05 + 30,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 30,
                        height: h * 0.45,
                        color: AppColor.coreColor,
                      ),
                      Container(
                        width: w * 0.05,
                        height: h * 0.4,
                        decoration: const BoxDecoration(
                          color: AppColor.coreColor,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: h * 0.28,
                child: _bodySection(w, h),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _topSection(w, h) {
    return Container(
      height: h * 0.28,
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColor.coreColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(60),
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05 + 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: h * 0.08,
            margin: EdgeInsets.only(top: h * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 30,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(),
                ),
                Container(
                  width: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(0, 0),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.network(
                    widget.con.userSession.avatar!,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              // height: h * 0.15,
              // color: Colors.red,
              margin: EdgeInsets.only(top: h * 0.02, bottom: h * 0.04),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 30,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DateFormat("MMM").format(now),
                          style: GoogleFonts.robotoSlab(
                            color: AppColor.coreColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          now.day.toString(),
                          style: GoogleFonts.robotoSlab(
                            color: AppColor.coreColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodySection(w, h) {
    return Container(
      width: w * 0.95,
      height: h * 0.58,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(50),
          bottomLeft: Radius.circular(50),
        ),
      ),
      padding: const EdgeInsets.all(40),
      child: Column(
        children: [
          SizedBox(
            width: w * 0.95,
            height: 50,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.con.selectedDayInWeek.length,
              separatorBuilder: (_, index) {
                return SizedBox(
                  width: (w * 0.95 - 40 * 2 - 50 * 7) / 6,
                );
              },
              itemBuilder: (_, index) {
                return Obx(
                  () => GestureDetector(
                    onTap: () {
                      widget.con.selectedDayInWeek[index]['isSelected']!.value =
                          !widget.con.selectedDayInWeek[index]['isSelected']!
                              .value;
                    },
                    child: SizedBox(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.linear,
                          width: widget.con
                                  .selectedDayInWeek[index]['isSelected']!.value
                              ? 50
                              : 45,
                          height: widget.con
                                  .selectedDayInWeek[index]['isSelected']!.value
                              ? 50
                              : 45,
                          decoration: BoxDecoration(
                            color: widget
                                    .con
                                    .selectedDayInWeek[index]['isSelected']!
                                    .value
                                ? AppColor.coreColor
                                : Colors.white,
                            border: widget
                                    .con
                                    .selectedDayInWeek[index]['isSelected']!
                                    .value
                                ? null
                                : Border.all(
                                    color: Colors.black87,
                                    width: 1.5,
                                  ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Center(
                            child: Text(
                              widget.con.selectedDayInWeek[index]['dayInWeek']!
                                  .value,
                              style: GoogleFonts.roboto(
                                color: widget
                                        .con
                                        .selectedDayInWeek[index]['isSelected']!
                                        .value
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: widget
                                        .con
                                        .selectedDayInWeek[index]['isSelected']!
                                        .value
                                    ? 20
                                    : 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            child: TextField(
              controller: widget.con.nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: "typing...",
                hintStyle: GoogleFonts.robotoSlab(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColor.inactiveColor,
                ),
                labelText: "Routine Name",
                labelStyle: GoogleFonts.robotoSlab(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding: const EdgeInsets.all(20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            child: Obx(
              () => Wrap(
                // children: <Widget>[timeWidgets],
                children: timeWidgets,
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColor.inactiveColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: InkWell(
                onTap: () {
                  _addNewTimeWidget();
                },
                splashColor: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(15),
                child: const Center(
                  child: FaIcon(FontAwesomeIcons.plus),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _botSection() {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FaIcon(
            FontAwesomeIcons.solidBell,
            size: 30,
            color: Colors.grey[400],
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            "Notify me",
            style: GoogleFonts.robotoSlab(
              color: Colors.grey[400],
              fontSize: 22,
              fontWeight: FontWeight.w500,
            ),
          ),
          const Expanded(
            child: SizedBox(),
          ),
          Obx(
            () => Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    widget.con.isNotify.value = !widget.con.isNotify.value;
                  },
                  child: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      color: widget.con.isNotify.value
                          ? const Color(0xFF39C8B7)
                          : Colors.grey[400],
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                  top: 5,
                  bottom: 5,
                  left: widget.con.isNotify.value ? 80 - 5 - 30 : 5,
                  child: GestureDetector(
                    onTap: () {
                      widget.con.isNotify.value = !widget.con.isNotify.value;
                    },
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: AppColor.routineColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
