import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/helpers/number_helper.dart';
import 'package:skinpal/pages/product/product_detail_controller.dart';

class ProductDetailPage extends StatelessWidget {
  ProductDetailPage({super.key});

  ProductDetailController con = Get.put(ProductDetailController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Separate from constructor => Allow to print()
    con.checkProductInCart();

    return SafeArea(
        child: Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: h * 0.06,
                  ),
                  Center(
                    child: Text(
                      "Product Detail",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.02,
                  ),
                  _productName(),
                  SizedBox(
                    height: h * 0.03,
                  ),
                  _productImage(),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        _productFavPrice(),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        _productDesc(),
                        SizedBox(
                          height: h * 0.02,
                        ),
                        _productInstruction(w, h),
                        SizedBox(
                          height: h * 0.03,
                        ),
                        _productAvoidance(w, h),
                        SizedBox(
                          height: h * 0.06,
                        ),
                        if (!con.fromCart) _button(w),
                        SizedBox(
                          height: h * 0.06,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              top: 30,
              left: 30,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 30,
                  color: AppColor.inactiveColor,
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _productName() {
    return Text(
      textAlign: TextAlign.center,
      con.product.name!,
      style: GoogleFonts.robotoSlab(
        fontSize: 22,
        fontWeight: FontWeight.w300,
      ),
    );
  }

  Widget _productImage() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 15,
            offset: const Offset(0, 2),
          ),
        ],
        borderRadius: BorderRadius.circular(70),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(70),
        child: Image.network(
          con.product.image!,
          width: 250,
          height: 250,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _productFavPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        con.product.favorite! != 0
            ? const FaIcon(
                FontAwesomeIcons.solidHeart,
                size: 30,
                color: Color(0xFFeb5757),
              )
            : const FaIcon(
                FontAwesomeIcons.heart,
                size: 30,
                // color: Color(0xFFeb5757),
              ),
        Text(
          "${NumberHelper.shortenedDouble(con.product.price!)} \$",
          style: GoogleFonts.robotoSlab(
            fontSize: 25,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _productDesc() {
    return Text(
      con.product.description ?? 'No Description...',
      style: GoogleFonts.robotoSlab(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Widget _productInstruction(w, h) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "How to use",
            style: GoogleFonts.robotoSlab(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            // "Use once or twice a week, ideally in the evening, on thoroughly clean, dry skin. Do not use on wet skin.",
            con.product.instruction['howToUse'] ?? '--',
            style: GoogleFonts.robotoSlab(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: w * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "When to use",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      // "Use in PM",
                      con.product.instruction['whenToUse'] ?? '--',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: w * 0.35,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Good for",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      // "12 months after opening",
                      con.product.instruction['goodFor'] ?? '--',
                      style: GoogleFonts.robotoSlab(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _productAvoidance(w, h) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 30),
          decoration: BoxDecoration(
            color: const Color(0xFFFB7B7B),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Text(
            "DO NOT USE WITH",
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoSlab(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisExtent: 75,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: con.product.avoidance!.length,
            itemBuilder: (_, index) {
              return Container(
                alignment: Alignment.center,
                height: 75,
                decoration: BoxDecoration(
                  color: AppColor.secondaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  con.product.avoidance![index].name!,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            }),
      ],
    );
  }

  Widget _button(w) {
    return GestureDetector(
      onTap: () => con.addToCart(),
      child: Container(
        width: w * 0.5,
        padding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        decoration: BoxDecoration(
          color: AppColor.coreColor,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.cartShopping,
              size: 25,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "BUY",
              style: GoogleFonts.robotoSlab(
                color: Colors.white,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
