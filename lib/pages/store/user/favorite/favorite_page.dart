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
    return FutureBuilder(
      future: widget.con.getFavoriteProducts(),
      builder: (context, AsyncSnapshot<List<Product>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.isNotEmpty) {
            return GridView.builder(
              //Custom item in a row
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 25,
                mainAxisSpacing: 50,
                mainAxisExtent: h * 0.3,
              ),
              shrinkWrap: true,
              // physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 30,
              ),
              itemBuilder: (_, index) {
                return _singleItem(h, snapshot.data![index]);
              },
            );
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
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
                // "https://cdn.cliqueinc.com/posts/285756/best-skincare-brands-285756-1582682027978-main.700x0c.jpg",
                product.image!,
                width: double.infinity,
                height: h * 0.2,
                fit: BoxFit.contain,
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
                width: 20,
              ),
              GestureDetector(
                onTap: () {
                  if (product.favorite != null) {
                    widget.con.cutFavorite(product.id!);
                  } else {
                    widget.con.addFavorite(product.id!);
                  }
                },
                child: FaIcon(
                  FontAwesomeIcons.solidHeart,
                  size: 25,
                  color:
                      product.favorite != null ? const Color(0xFFeb5757) : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
