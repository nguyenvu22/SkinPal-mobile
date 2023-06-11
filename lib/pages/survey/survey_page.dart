import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/survey/survey_controller.dart';

class SurveyPage extends StatefulWidget {
  SurveyPage({super.key});

  SurveyController con = Get.put(SurveyController());

  @override
  State<SurveyPage> createState() => _SurveyPageState();
}

class _SurveyPageState extends State<SurveyPage> {
  final controller = PageController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            _buildPage1(w, h),
            _buildPage2(w, h),
          ],
        ),
      ),
    );
  }

  Widget _buildPage2(w, h) {
    return Column(
      children: [
        GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 25,
            mainAxisSpacing: 35,
            mainAxisExtent: 300,
          ),
          itemCount: 4,
          itemBuilder: (_, index) => Column(
            children: [
              Image.network(widget.con.skinTypeList[index]['image']),
              Text(
                widget.con.skinTypeList[index]['name'],
                style: GoogleFonts.robotoSlab(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPage1(w, h) {
    return Column(
      children: [
        Container(
          height: h * 0.1,
          color: AppColor.coreColor,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Khảo sát",
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => controller.nextPage(
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeInOut,
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        "Next",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: DefaultTabController(
            length: 4,
            child: Column(
              children: [
                Container(
                  color: AppColor.coreColor,
                  padding: const EdgeInsets.only(bottom: 20),
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "Câu hỏi 1",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Câu hỏi 2",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Câu hỏi 3",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Câu hỏi 4",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                    isScrollable: false,
                    indicator: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.white,
                          width: 4,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: h * 0.02,
                  color: Colors.black12,
                ),
                FutureBuilder<void>(
                  future: widget.con.loadData(),
                  builder: (_, AsyncSnapshot<void> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(); // or any loading indicator
                    } else {
                      return Expanded(
                        child: TabBarView(
                          children: [
                            Container(
                              color: Colors.black12,
                              child: _questionPage(w, h, "answer1"),
                            ),
                            Container(
                              color: Colors.black12,
                              child: _questionPage(w, h, "answer2"),
                            ),
                            Container(
                              color: Colors.black12,
                              child: _questionPage(w, h, "answer3"),
                            ),
                            Container(
                              color: Colors.black12,
                              child: _questionPage(w, h, "answer4"),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        Container(
          height: h * 0.02,
          color: Colors.black12,
        ),
      ],
    );
  }

  Widget _questionPage(w, h, answer) {
    return Column(
      children: [
        _answerOption(w, h, 0, answer),
        _answerOption(w, h, 1, answer),
        _answerOption(w, h, 2, answer),
        _answerOption(w, h, 3, answer),
      ],
    );
  }

  Widget _answerOption(w, h, index, answer) {
    // Which page
    int page = int.parse(answer.split("").last);
    return Flexible(
      child: Bounce(
        onPressed: () {
          widget.con.addAnswer(page - 1, index + 1);
        },
        duration: const Duration(milliseconds: 300),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                spreadRadius: 3,
                color: Colors.black12,
                offset: Offset(0, 5),
              )
            ],
          ),
          child: Row(
            children: [
              Container(
                width: w * 0.25,
                decoration: BoxDecoration(
                  color: AppColor.coreColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.only(
                  left: 20,
                ),
                child: Image.network(widget.con.skinTypeList[index]['image']),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 30, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.con.quesList[index][answer].split(":").first,
                            style: GoogleFonts.robotoSlab(
                              color: AppColor.coreColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 20,
                          bottom: 5,
                        ),
                        child: Text(
                          widget.con.quesList[index]['$answer'].split(":").last,
                          style: GoogleFonts.robotoSlab(
                            fontSize: 14,
                          ),
                          maxLines: 3,
                        ),
                      ),
                      const Divider(color: Colors.black38, thickness: 2),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 5,
                          left: 30,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColor.coreColor,
                                ),
                                child: const FaIcon(
                                  FontAwesomeIcons.percent,
                                  color: Colors.white,
                                  size: 15,
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Stack(
                                children: [
                                  Container(
                                    width: 200,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.black26,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  Obx(
                                    () => AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      curve: Curves.easeInOut,
                                      width: 200 *
                                          (widget.con.countMap
                                                  .where((value) =>
                                                      value.value == index + 1)
                                                  .length /
                                              4),
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: AppColor.coreColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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
        ),
      ),
    );
  }
}
