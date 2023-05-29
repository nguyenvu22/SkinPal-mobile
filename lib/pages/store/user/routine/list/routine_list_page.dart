import 'package:flutter/material.dart';
import 'dart:math';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/models/routine.dart';
import 'package:skinpal/pages/store/user/routine/list/routine_list_controller.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:intl/intl.dart';
import 'package:skinpal/widgets/no_data_widget.dart';

class RoutineListPage extends StatefulWidget {
  RoutineListPage({super.key});

  RoutineListController con = Get.put(RoutineListController());

  @override
  State<RoutineListPage> createState() => _RoutineListPageState();
}

class _RoutineListPageState extends State<RoutineListPage>
    with TickerProviderStateMixin {
  List<String> weeklyDate = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];

  TabController? tabController;
  int? initIndex;
  int selectedTabIndex = 0;
  final now = DateTime.now();

  bool toggle = true;
  late AnimationController _animationController;
  late Animation _animation;
  Alignment alignment1 = const Alignment(1.0, 1.0);
  Alignment alignment2 = const Alignment(1.0, 1.0);
  double size = 50;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      reverseDuration: const Duration(milliseconds: 350),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
      reverseCurve: Curves.easeIn,
    );
    _animationController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  // Dont init normally by initState but async by FutureBuilder
  Future<void> initTabController() async {
    // widget.con.initController();
    if (tabController == null) {
      setState(() {
        // initIndex = weeklyDate.indexOf(widget.con.todayWeekly!);
        initIndex =
            weeklyDate.indexOf(DateFormat('EEEE').format(DateTime.now()));
        tabController = TabController(
          length: weeklyDate.length,
          vsync: this,
          initialIndex: initIndex ?? 0,
        );
      });
      selectedTabIndex = initIndex!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    widget.con.initController();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: DefaultTabController(
          length: widget.con.weekDates.length,
          child: Stack(
            children: [
              Positioned(
                right: 0,
                top: h * 0.075,
                child: Row(
                  children: [
                    Container(
                      height: h * 0.3,
                      width: 30,
                      decoration: const BoxDecoration(
                        color: AppColor.routineColor,
                      ),
                    ),
                    Container(
                      height: h * 0.3,
                      width: w * 0.05,
                      decoration: const BoxDecoration(
                        color: AppColor.routineColor,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(60),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: h * 0.33,
                margin: EdgeInsets.only(
                  right: w * 0.05,
                ),
                padding: EdgeInsets.only(
                  left: w * 0.05 + 30,
                  right: 30,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30),
                  ),
                ),
                clipBehavior: Clip.antiAlias,
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
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              "Routines",
                              style: GoogleFonts.robotoSlab(
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.center,
                            ),
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
                                      color: Colors.black26,
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
                    Container(
                      height: h * 0.1,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        widget.con.currentMonth!,
                        style: GoogleFonts.robotoSlab(
                          color: AppColor.secondaryColor,
                          fontSize: 45,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: SizedBox(
                          height: h * 0.15,
                          child: Theme(
                            data: ThemeData().copyWith(
                              splashColor: Colors.transparent,
                              highlightColor: Colors.transparent,
                            ),
                            child:
                                //Need to wait for todayWeekly to be initialize
                                FutureBuilder(
                              future: initTabController(),
                              builder: ((context, snapshot) {
                                return TabBar(
                                  controller: tabController,
                                  indicatorColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: AppColor.coreColor.withOpacity(0.3),
                                  ),
                                  labelColor: AppColor.coreColor,
                                  tabs: weeklyDate.map(
                                    (date) {
                                      final index = weeklyDate.indexOf(date);
                                      return Tab(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              date.split('')[0],
                                              style: GoogleFonts.robotoSlab(
                                                color: selectedTabIndex == index
                                                    ? AppColor.coreColor
                                                    : Colors.black,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Text(
                                              widget.con.weekDates[index],
                                              style: GoogleFonts.robotoSlab(
                                                color: selectedTabIndex == index
                                                    ? AppColor.coreColor
                                                    : AppColor.secondaryColor,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ).toList(),
                                  onTap: (index) {
                                    setState(() {
                                      selectedTabIndex = index;
                                    });
                                  },
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: h * 0.645,
                  width: w,
                  decoration: const BoxDecoration(
                    color: AppColor.routineColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 30,
                    ),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        ...weeklyDate.map(
                          (w) => FutureBuilder(
                            future: widget.con.getRoutine(w),
                            builder: (
                              context,
                              AsyncSnapshot<List<Routine>> snapshot,
                            ) {
                              // final now = DateTime.now().weekday - 1;
                              // final now1 = weeklyDate.indexOf(w);
                              final isToday =
                                  now.weekday - 1 == weeklyDate.indexOf(w)
                                      ? true
                                      : false;

                              if (snapshot.hasData) {
                                if (snapshot.data!.isNotEmpty) {
                                  // Sort the time ascending
                                  List<Map<String, dynamic>>
                                      routineSortedByTime = [];
                                  // Loop through each Routine object in your original list of routines.
                                  for (Routine routine in snapshot.data!) {
                                    // For each Routine object, loop through its schedules list.
                                    for (String time in routine.schedules!) {
                                      routineSortedByTime.add({
                                        "time": time,
                                        "routineName": routine.name,
                                        "routineSteps": routine.steps,
                                      });
                                    }
                                  }
                                  // Sort the list by the time value in ascending order.
                                  routineSortedByTime.sort(
                                      // (a, b) => a["time"].compareTo(b["time"])
                                      (a, b) {
                                    var timeA = a["time"].split(":");
                                    var timeB = b["time"].split(":");
                                    // Separate hour and minute to compare
                                    var hourA = int.parse(timeA[0]);
                                    var hourB = int.parse(timeB[0]);
                                    var minuteA = int.parse(timeA[1]);
                                    var minuteB = int.parse(timeB[1]);
                                    if (hourA < hourB) {
                                      // Not swap position
                                      return -1;
                                    } else if (hourA > hourB) {
                                      // Swap position
                                      return 1;
                                    } else {
                                      return minuteA.compareTo(minuteB);
                                    }
                                  });

                                  // Find nearest time to the current moment
                                  // Map<String, dynamic>? nearestRoutine;
                                  String? nearestRoutineTime;
                                  for (Map<String, dynamic> routine
                                      in routineSortedByTime) {
                                    // Parse to DateTime type to compare (ex. 2023-05-06 02:45:27.307782)
                                    DateTime routineDateTime = DateTime.parse(
                                        "${now.toString().split(" ")[0]} ${routine['time']}:00");

                                    if (routineDateTime.isAfter(now)) {
                                      // nearestRoutine = routine;
                                      nearestRoutineTime = routine['time'];
                                      break;
                                    }
                                  }

                                  return SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ...routineSortedByTime.map((routine) {
                                          final index = routineSortedByTime
                                              .indexOf(routine);
                                          return TimelineTile(
                                            isFirst: index == 0 ? true : false,
                                            alignment: TimelineAlign.manual,
                                            lineXY: 0.12, // 12%
                                            beforeLineStyle: const LineStyle(
                                              color: AppColor.secondaryColor,
                                              thickness: 1.5,
                                            ),
                                            afterLineStyle: const LineStyle(
                                              color: AppColor.secondaryColor,
                                              thickness: 1.5,
                                            ),
                                            indicatorStyle: index != 0
                                                ? routineSortedByTime[index - 1]
                                                            ['time'] ==
                                                        routine['time']
                                                    ? const IndicatorStyle(
                                                        width: 80,
                                                        height: 30,
                                                        color:
                                                            Colors.transparent,
                                                      )
                                                    : IndicatorStyle(
                                                        color:
                                                            AppColor.coreColor,
                                                        width: 80,
                                                        height: 30,
                                                        indicator: Stack(
                                                          children: [
                                                            Positioned(
                                                              top: 0,
                                                              bottom: 0,
                                                              left: 0,
                                                              right: 0,
                                                              child: Container(
                                                                height: double
                                                                    .infinity,
                                                                width: double
                                                                    .infinity,
                                                                color: AppColor
                                                                    .routineColor,
                                                              ),
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: isToday
                                                                    ? routine['time'] ==
                                                                            nearestRoutineTime
                                                                        ? Colors
                                                                            .white
                                                                            .withOpacity(
                                                                                0.1)
                                                                        : Colors
                                                                            .black
                                                                            .withOpacity(
                                                                                0.2)
                                                                    : Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.2),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                border: isToday
                                                                    ? routine['time'] ==
                                                                            nearestRoutineTime
                                                                        ? Border
                                                                            .all(
                                                                            width:
                                                                                2,
                                                                            color:
                                                                                AppColor.coreColor,
                                                                          )
                                                                        : const Border()
                                                                    : const Border(),
                                                              ),
                                                              child: Center(
                                                                child: Text(
                                                                  routine[
                                                                      'time'],
                                                                  style: GoogleFonts
                                                                      .robotoSlab(
                                                                    color: isToday
                                                                        ? routine['time'] == nearestRoutineTime
                                                                            ? AppColor.coreColor
                                                                            : Colors.white
                                                                        : Colors.white,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      )
                                                : IndicatorStyle(
                                                    color: AppColor.coreColor,
                                                    width: 80,
                                                    height: 30,
                                                    indicator: Stack(
                                                      children: [
                                                        Positioned(
                                                          top: 0,
                                                          bottom: 0,
                                                          left: 0,
                                                          right: 0,
                                                          child: Container(
                                                            height:
                                                                double.infinity,
                                                            width:
                                                                double.infinity,
                                                            color: AppColor
                                                                .routineColor,
                                                          ),
                                                        ),
                                                        Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: isToday
                                                                ? routine['time'] ==
                                                                        nearestRoutineTime
                                                                    ? Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.1)
                                                                    : Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.2)
                                                                : Colors.black
                                                                    .withOpacity(
                                                                        0.2),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            border: isToday
                                                                ? routine['time'] ==
                                                                        nearestRoutineTime
                                                                    ? Border
                                                                        .all(
                                                                        width:
                                                                            2,
                                                                        color: AppColor
                                                                            .coreColor,
                                                                      )
                                                                    : const Border()
                                                                : const Border(),
                                                          ),
                                                          child: Center(
                                                            child: Text(
                                                              routine['time'],
                                                              style: GoogleFonts
                                                                  .robotoSlab(
                                                                color: isToday
                                                                    ? routine['time'] ==
                                                                            nearestRoutineTime
                                                                        ? AppColor
                                                                            .coreColor
                                                                        : Colors
                                                                            .white
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 18,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                            endChild: Column(
                                              children: [
                                                Flexible(
                                                  child: Container(
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 40,
                                                      vertical: 20,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 45,
                                                      vertical: 30,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color: isToday &&
                                                              routine['time'] ==
                                                                  nearestRoutineTime
                                                          ? AppColor.coreColor
                                                          : Colors.black26,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                        topLeft: const Radius
                                                            .circular(40),
                                                        bottomLeft: const Radius
                                                            .circular(40),
                                                        bottomRight: isToday &&
                                                                routine['time'] ==
                                                                    nearestRoutineTime
                                                            ? const Radius
                                                                .circular(40)
                                                            : const Radius
                                                                .circular(0),
                                                        topRight: isToday &&
                                                                routine['time'] ==
                                                                    nearestRoutineTime
                                                            ? const Radius
                                                                .circular(0)
                                                            : const Radius
                                                                .circular(40),
                                                      ),
                                                      boxShadow: [
                                                        if (isToday &&
                                                            routine['time'] ==
                                                                nearestRoutineTime)
                                                          const BoxShadow(
                                                            spreadRadius: 1,
                                                            blurRadius: 15,
                                                            color:
                                                                Colors.black38,
                                                          ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        SizedBox(
                                                          height: 30,
                                                          width:
                                                              double.infinity,
                                                          child: Row(
                                                            children: [
                                                              Container(
                                                                color: isToday &&
                                                                        routine['time'] ==
                                                                            nearestRoutineTime
                                                                    ? Colors
                                                                        .white
                                                                    : AppColor
                                                                        .coreColor,
                                                                width: 5,
                                                              ),
                                                              const SizedBox(
                                                                width: 25,
                                                              ),
                                                              Text(
                                                                routine[
                                                                    'routineName'],
                                                                style: GoogleFonts
                                                                    .robotoSlab(
                                                                  color: isToday
                                                                      ? routine['time'] ==
                                                                              nearestRoutineTime
                                                                          ? AppColor
                                                                              .routineColor
                                                                          : Colors
                                                                              .white
                                                                      : Colors
                                                                          .white,
                                                                  fontSize: 24,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 20,
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ...routine[
                                                                        'routineSteps']
                                                                    .map(
                                                                        (step) {
                                                                  return Text(
                                                                    "• ${step}",
                                                                    style: GoogleFonts
                                                                        .robotoSlab(
                                                                      color: isToday
                                                                          ? routine['time'] == nearestRoutineTime
                                                                              ? AppColor.routineColor
                                                                              : Colors.white
                                                                          : Colors.white,
                                                                      fontSize:
                                                                          18,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                    ),
                                                                  );
                                                                }),
                                                              ],
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
                                        }),
                                        TimelineTile(
                                          isLast: true,
                                          beforeLineStyle: const LineStyle(
                                            color: AppColor.secondaryColor,
                                            thickness: 1.5,
                                          ),
                                          alignment: TimelineAlign.manual,
                                          lineXY: 0.12,
                                          indicatorStyle: IndicatorStyle(
                                            height: 60,
                                            width: 60,
                                            indicator: Stack(
                                              children: [
                                                Positioned(
                                                  top: 0,
                                                  bottom: 0,
                                                  left: 0,
                                                  right: 0,
                                                  child: Container(
                                                    color:
                                                        AppColor.routineColor,
                                                  ),
                                                ),
                                                Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.black
                                                        .withOpacity(0.2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: const Icon(
                                                    Icons.alarm_sharp,
                                                    color: Colors.white,
                                                    size: 35,
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
                                return NoDataWidget(
                                  text: "No routine for today",
                                  img: "assets/images/empty_item.png",
                                );
                              }
                              return NoDataWidget(
                                text: "No routine for today",
                                img: "assets/images/empty_item.png",
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: h * 0.05,
                right: w * 0.1,
                child: _customFloatingButton(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customFloatingButton() {
    return SizedBox(
      width: 150,
      height: 150,
      child: Stack(
        children: [
          AnimatedAlign(
            alignment: alignment1,
            duration: toggle
                ? const Duration(milliseconds: 300)
                : const Duration(milliseconds: 700),
            curve: toggle ? Curves.easeIn : Curves.easeOut,
            child: GestureDetector(
              onTap: () => widget.con.goToCreateRoutine(context),
              child: Container(
                margin: const EdgeInsets.all(5),
                child: AnimatedContainer(
                  duration: toggle
                      ? const Duration(milliseconds: 300)
                      : const Duration(milliseconds: 700),
                  curve: toggle ? Curves.easeIn : Curves.easeOut,
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(size),
                  ),
                  child: Center(
                    child: FaIcon(
                      FontAwesomeIcons.calendarPlus,
                      size: size / 2,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            alignment: alignment2,
            duration: toggle
                ? const Duration(milliseconds: 300)
                : const Duration(milliseconds: 700),
            curve: toggle ? Curves.easeIn : Curves.easeOut,
            child: Container(
              margin: const EdgeInsets.all(5),
              child: AnimatedContainer(
                duration: toggle
                    ? const Duration(milliseconds: 300)
                    : const Duration(milliseconds: 700),
                curve: toggle ? Curves.easeIn : Curves.easeOut,
                width: size,
                height: size,
                decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(size),
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.calendarPlus,
                    size: size / 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                boxShadow: const [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.black45,
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: _animation.value * pi * (3 / 4),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    curve: Curves.easeOut,
                    width: toggle ? 60 : 50,
                    height: toggle ? 60 : 50,
                    decoration: BoxDecoration(
                      color: toggle ? AppColor.coreColor : Colors.black,
                      borderRadius: BorderRadius.circular(60),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (toggle) {
                              toggle = !toggle;
                              _animationController.forward();
                              Future.delayed(
                                const Duration(milliseconds: 10),
                                () {
                                  alignment1 = const Alignment(-1.0, 0.5);
                                  alignment2 = const Alignment(0.5, -1.0);
                                  size = 50;
                                },
                              );
                            } else {
                              toggle = !toggle;
                              _animationController.reverse();
                              alignment1 = const Alignment(1.0, 1.0);
                              alignment2 = const Alignment(1.0, 1.0);
                              size = 30;
                            }
                          });
                        },
                        splashColor: Colors.transparent,
                        icon: FaIcon(
                          FontAwesomeIcons.plus,
                          size: 30,
                          color: toggle ? Colors.black : AppColor.coreColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
