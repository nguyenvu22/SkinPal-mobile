import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/helpers/number_helper.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/store/cart/cart_controller.dart';
import 'package:skinpal/widgets/no_data_widget.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  CartController con = Get.put(CartController());

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Separate from constructor
    widget.con.initController();

    return Obx(
      () => SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              SizedBox(
                height: h * 0.05,
              ),
              Center(
                child: Text(
                  "My Shopping Bag",
                  style: GoogleFonts.robotoSlab(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: h * 0.03,
              ),
              _buildListView(w, h),
              SizedBox(
                height: h * 0.05,
              ),
              _buildCheckout(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListView(w, h) {
    return SizedBox(
      height: h * 0.65,
      child: widget.con.productInCart.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemCount: widget.con.productInCart.length,
              itemBuilder: (context, index) {
                return _buildListViewItem(widget.con.productInCart[index]);
              },
            )
          : NoDataWidget(
              text: "Your bag is empty.",
            ),
    );
  }

  Widget _buildListViewItem(Product product) {
    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColor.secondaryColor,
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => widget.con.goToProductDetail(product),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(120),
                border: Border.all(
                  width: 1,
                ),
              ),
              clipBehavior: Clip.hardEdge,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(120),
                child: Image.network(
                  product.image!,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 200,
                        child: Text(
                          product.name!,
                          style: GoogleFonts.robotoSlab(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => widget.con.removeToCart(product),
                        child: const FaIcon(
                          FontAwesomeIcons.x,
                          size: 16,
                          color: AppColor.secondaryColor,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    product.description ?? '--',
                    style: GoogleFonts.robotoSlab(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () => widget.con.minusLessItem(product),
                            child: const FaIcon(
                              FontAwesomeIcons.minus,
                              size: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            product.quantity.toString(),
                            style: GoogleFonts.robotoSlab(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () => widget.con.plusMoreItem(product),
                            child: const FaIcon(
                              FontAwesomeIcons.plus,
                              size: 16,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "\$${NumberHelper.shortenedDouble(product.price! * product.quantity!)}",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildCheckout() {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${widget.con.storeController.itemCounter.toString()} ${widget.con.storeController.itemCounter == 1 ? 'item' : 'items'}",
            style: GoogleFonts.robotoSlab(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: 250,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColor.coreColor,
                width: 2,
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: Text(
                      "\$${NumberHelper.shortenedDouble(widget.con.totalPrice.value)}",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  decoration: BoxDecoration(
                    color: AppColor.coreColor,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: GestureDetector(
                    onTap: () => widget.con.goToCheckout(),
                    child: Text(
                      "Buy now",
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
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