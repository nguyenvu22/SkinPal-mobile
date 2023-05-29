import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
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

  // DateTime d1 = DateTime.now();
  TimeOfDay? time1, time2, time3;

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
              Positioned(
                top: h * 0.28 + h * 0.58 - 30 / 2 - 5,
                left: w * 0.65,
                child: Bounce(
                  duration: const Duration(milliseconds: 200),
                  onPressed: () {},
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColor.coreColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const FaIcon(
                      FontAwesomeIcons.arrowRight,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white,
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black54,
                            blurRadius: 5,
                            offset: Offset(0, 0),
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Image.network(
                        widget.con.userSession.avatar!,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
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
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Text(
                        "Create your own routine.",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "What to note?",
              style: GoogleFonts.robotoSlab(fontSize: 25),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 5,
              ),
              child: Text(
                "Date in week",
                style: GoogleFonts.robotoSlab(fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
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
                        widget.con.selectedDayInWeek[index]['isSelected']!
                                .value =
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
                            width: widget
                                    .con
                                    .selectedDayInWeek[index]['isSelected']!
                                    .value
                                ? 50
                                : 45,
                            height: widget
                                    .con
                                    .selectedDayInWeek[index]['isSelected']!
                                    .value
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
                                      width: 2,
                                    ),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "${widget.con.selectedDayInWeek[index]['dayInWeek']!.value.split('')[0]}",
                                style: GoogleFonts.roboto(
                                  color: widget
                                          .con
                                          .selectedDayInWeek[index]
                                              ['isSelected']!
                                          .value
                                      ? Colors.white
                                      : Colors.black87,
                                  fontSize: widget
                                          .con
                                          .selectedDayInWeek[index]
                                              ['isSelected']!
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
                // style: TextStyle(color: AppColor.coreColor),
                decoration: InputDecoration(
                  floatingLabelStyle:
                      TextStyle(color: AppColor.coreColor, fontSize: 20),
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
                  enabledBorder: widget.con.nameController.text.isNotEmpty
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColor.coreColor,
                            width: 2,
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: AppColor.secondaryColor,
                            width: 2,
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 10,
              ),
              child: Text(
                "Routine schedules",
                style: GoogleFonts.robotoSlab(fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  Bounce(
                    duration: const Duration(milliseconds: 200),
                    onPressed: () {
                      showCupertinoModalPopup(
                        context: context,
                        builder: (_) => SizedBox(
                          height: h * 0.4,
                          child: CupertinoDatePicker(
                            backgroundColor: Colors.white,
                            initialDateTime: DateTime.now(),
                            mode: CupertinoDatePickerMode.time,
                            use24hFormat: true,
                            onDateTimeChanged: (value) => setState(() {
                              time1 = TimeOfDay.fromDateTime(value);
                              // time2 = time1;
                            }),
                          ),
                        ),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Time",
                            style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            time1 != null
                                ? "${time1!.hour}:${time1!.minute}"
                                : "00:00",
                            style: GoogleFonts.robotoSlab(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Bounce(
                        duration: const Duration(milliseconds: 200),
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => SizedBox(
                              height: h * 0.4,
                              child: CupertinoDatePicker(
                                backgroundColor: Colors.white,
                                initialDateTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  time1 != null ? time1!.hour : 0,
                                  time1 != null ? time1!.minute : 0,
                                ),
                                minimumDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  time1 != null ? time1!.hour : 0,
                                  time1 != null ? time1!.minute : 0,
                                ),
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                onDateTimeChanged: (value) => setState(() {
                                  time2 = TimeOfDay.fromDateTime(value);
                                  // time3 = time2;
                                }),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: time1 == null
                                  ? AppColor.secondaryColor
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Time",
                                style: GoogleFonts.robotoSlab(
                                  color: time1 == null
                                      ? AppColor.secondaryColor
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                time2 != null
                                    ? "${time2!.hour}:${time2!.minute}"
                                    : time1 != null
                                        ? "${time1!.hour}:${time1!.minute}"
                                        : "00:00",
                                style: GoogleFonts.robotoSlab(
                                  color: time1 == null
                                      ? AppColor.secondaryColor
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (time1 == null)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Bounce(
                        duration: const Duration(milliseconds: 200),
                        onPressed: () {
                          showCupertinoModalPopup(
                            context: context,
                            builder: (_) => SizedBox(
                              height: h * 0.4,
                              child: CupertinoDatePicker(
                                backgroundColor: Colors.white,
                                initialDateTime: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  time2 != null ? time2!.hour : 0,
                                  time2 != null ? time2!.minute : 0,
                                ),
                                minimumDate: DateTime(
                                  DateTime.now().year,
                                  DateTime.now().month,
                                  DateTime.now().day,
                                  time2 != null ? time2!.hour : 0,
                                  time2 != null ? time2!.minute : 0,
                                ),
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                onDateTimeChanged: (value) => setState(() {
                                  time3 = TimeOfDay.fromDateTime(value);
                                }),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 15,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1.5,
                              color: time2 == null || time1 == null
                                  ? AppColor.secondaryColor
                                  : Colors.black,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Time",
                                style: GoogleFonts.robotoSlab(
                                  color: time2 == null || time1 == null
                                      ? AppColor.secondaryColor
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                time3 != null
                                    ? "${time3!.hour}:${time3!.minute}"
                                    : time2 != null
                                        ? "${time2!.hour}:${time2!.minute}"
                                        : "00:00",
                                style: GoogleFonts.robotoSlab(
                                  color: time2 == null || time1 == null
                                      ? AppColor.secondaryColor
                                      : Colors.black,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      if (time2 == null || time1 == null)
                        Positioned(
                          top: 0,
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              color: Colors.black12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                left: 15,
                bottom: 10,
              ),
              child: Text(
                "Routine steps - custom for your own",
                style: GoogleFonts.robotoSlab(fontSize: 15),
                textAlign: TextAlign.left,
              ),
            ),
            Flexible(
              child: Column(
                children: [
                  TextField(
                    controller: widget.con.step1Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "Your first step",
                      hintStyle: GoogleFonts.robotoSlab(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.inactiveColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      enabledBorder: widget.con.step1Controller.text.isNotEmpty
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.coreColor,
                                width: 2,
                              ),
                            )
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.secondaryColor,
                                width: 2,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: widget.con.step2Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "The second step",
                      hintStyle: GoogleFonts.robotoSlab(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.inactiveColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      enabledBorder: widget.con.step2Controller.text.isNotEmpty
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.coreColor,
                                width: 2,
                              ),
                            )
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.secondaryColor,
                                width: 2,
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: widget.con.step3Controller,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: "The last step",
                      hintStyle: GoogleFonts.robotoSlab(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: AppColor.inactiveColor,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      enabledBorder: widget.con.step3Controller.text.isNotEmpty
                          ? OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.coreColor,
                                width: 2,
                              ),
                            )
                          : OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                              borderSide: const BorderSide(
                                color: AppColor.secondaryColor,
                                width: 2,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Container(
                alignment: Alignment.centerRight,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  decoration: BoxDecoration(
                    color: AppColor.coreColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: GestureDetector(
                    onTap: () {},
                    child: const Icon(
                      Icons.arrow_forward_rounded,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
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
