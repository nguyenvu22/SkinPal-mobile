import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/store/user/favorite/favorite_controller.dart';

class FavortitePage extends StatefulWidget {
  FavoriteController con = Get.put(FavoriteController());

  @override
  State<FavortitePage> createState() => _FavortitePageState();
}

class _FavortitePageState extends State<FavortitePage> {
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
            margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    "Sản phẩm ưa thích",
                    style: GoogleFonts.robotoSlab(
                      fontSize: w * 0.07,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  _buildGridView(w, h),
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

  Widget _buildGridView(w, h) {
    return Obx(
      () => GridView.builder(
        //Custom item in a row
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25,
          mainAxisSpacing: 50,
          mainAxisExtent: h * 0.3,
        ),
        shrinkWrap: true,
        // physics: const NeverScrollableScrollPhysics(),
        itemCount: widget.con.productList.length,
        padding: const EdgeInsets.only(
          left: 15,
          right: 15,
          top: 30,
        ),
        itemBuilder: (_, index) {
          return _singleItem(h, widget.con.productList[index]);
        },
      ),
    );
  }

  Widget _singleItem(h, Product product) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          product.name!,
          style: GoogleFonts.robotoSlab(
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () =>
              Get.toNamed("/productDetail", arguments: {"product": product}),
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(
                width: 2,
                color: AppColor.secondaryColor,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.network(
                product.image!,
                width: double.infinity,
                height: h * 0.2,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => widget.con.deleteFromFavorite(product.id!),
                  child: const FaIcon(
                    FontAwesomeIcons.trashCan,
                    color: AppColor.secondaryColor,
                    size: 25,
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  // onTap: () => widget.con.favorite(product.id!),
                  child: FaIcon(
                    FontAwesomeIcons.solidHeart,
                    size: 25,
                    color: widget.con.favoriteList.contains(product.id)
                        ? const Color(0xFFeb5757)
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
