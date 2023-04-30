import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 6000), () {
      Get.offNamedUntil("/onboard", (route) => false);
    });

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.asset(
                "assets/images/splash_image.png",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Center(
                child: DefaultTextStyle(
                  // "SkinPal",
                  style: GoogleFonts.alata(
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width * 0.2,
                    fontWeight: FontWeight.w600,
                  ),
                  child: AnimatedTextKit(
                    animatedTexts: [
                      ScaleAnimatedText(
                        'SkinPal',
                      ),
                      RotateAnimatedText(
                        'Welcome to the beauty world.',
                        textStyle: TextStyle(
                          fontSize: MediaQuery.of(context).size.width * 0.1,
                        ),
                      ),
                    ],
                    repeatForever: true,
                    pause: const Duration(milliseconds: 1000),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
