import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/widgets/build_onboard.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboaradPage extends StatefulWidget {
  @override
  State<OnboaradPage> createState() => _OnboaradPageState();
}

class _OnboaradPageState extends State<OnboaradPage> {
  final controller = PageController();
  bool isLastPage = false;

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            bottom: h * 0.15,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: h * 0.7,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: PageView(
                  controller: controller,
                  onPageChanged: (index) {
                    setState(() => isLastPage = index == 2);
                  },
                  children: const [
                    BuildOnboard(
                      imgPath: "assets/images/onboard1.png",
                      title: "Discover your own beauty",
                      subTitle: "We are here to uncover your hidden beauty.",
                    ),
                    BuildOnboard(
                      imgPath: "assets/images/onboard2.png",
                      title: "Get advice directly from an expert",
                      subTitle:
                          "You can share directly with the expert at any time.",
                    ),
                    BuildOnboard(
                      imgPath: "assets/images/onboard3.png",
                      title: "Provide specific treatment process",
                      subTitle:
                          "Don’t know to make it? \nDon’t worry ! We will give it to you.",
                    ),
                  ],
                ),
              ),
              Center(
                child: SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: const WormEffect(
                    activeDotColor: Color(0xFFFE9C5E),
                    dotColor: Color(0xFFD8D8D8),
                    dotHeight: 20,
                    dotWidth: 20,
                    spacing: 20,
                  ),
                  onDotClicked: (index) => controller.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomSheet: Container(
          height: h * 0.15,
          padding:
              EdgeInsets.symmetric(horizontal: w * 0.25, vertical: h * 0.04),
          child: GestureDetector(
            onTap: () async {
              if (!isLastPage) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              } else {
                Get.offNamedUntil("/login", (route) => false);
                final prefs = await SharedPreferences.getInstance();
                prefs.setBool("isFirstMeet", true);
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColor.coreColor, Colors.white],
                  stops: [0.75, 1.0],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Text(
                isLastPage ? "Get Started" : "Next",
                style: GoogleFonts.acme(
                  color: Colors.white,
                  fontSize: w * 0.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
