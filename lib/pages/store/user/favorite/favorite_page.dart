import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';

class FavortitePage extends StatelessWidget {
  // const FavortitePage({super.key});

  List<String> list = ["ngu", "dot", "haha"];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "My Favorite",
                    style: GoogleFonts.robotoSlab(
                      fontSize: w * 0.07,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  _buildGridView(h),
                ],
              ),
            ),
          ),
          Positioned(
            top: 30,
            left: 30,
            child: _backButton(),
          )
        ],
      ),
    ));
  }

  Widget _backButton() {
    return GestureDetector(
      onTap: () => Get.back(),
      child: const Icon(
        Icons.arrow_back_ios_rounded,
        size: 30,
        color: AppColor.inactiveColor,
      ),
    );
  }

  Widget _buildGridView(h) {
    return GridView.builder(
      //Custom item in a row
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 35,
        mainAxisExtent: 270,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 5,
      padding: const EdgeInsets.only(
        left: 15,
        right: 15,
        top: 30,
      ),
      itemBuilder: (_, index) {
        return _singleItem(h);
      },
    );
  }

  Widget _singleItem(h) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Salicylic Acid",
          style: GoogleFonts.robotoSlab(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
        ),
        GestureDetector(
          onTap: () => Get.toNamed("/productDetail"),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1,
                color: AppColor.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                "https://cdn.cliqueinc.com/posts/285756/best-skincare-brands-285756-1582682027978-main.700x0c.jpg",
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: const FaIcon(
                  FontAwesomeIcons.trashCan,
                  color: AppColor.secondaryColor,
                  size: 25,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const FaIcon(
                FontAwesomeIcons.solidHeart,
                size: 25,
                color: Color(0xFFeb5757),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
