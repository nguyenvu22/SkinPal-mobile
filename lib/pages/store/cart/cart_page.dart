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
                  "Giỏ hàng",
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
              _buildCheckout(w, h),
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
              text: "Chưa có sản phẩm.",
              img: 'assets/images/no_item.png',
            ),
    );
  }

  Widget _buildListViewItem(Product product) {
    return Flexible(
      child: Container(
        // height: product.discount != 0 ? 180 : 160,
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 20,
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
                  boxShadow: const [
                    BoxShadow(
                      spreadRadius: 1,
                      blurRadius: 15,
                      color: Colors.black12,
                    ),
                  ],
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
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 15,
                        bottom: 10,
                      ),
                      child: Text(
                        product.description ?? '--',
                        style: GoogleFonts.robotoSlab(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (product.discount != 0)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Chip(
                          label: Text(
                            "- ${product.discount!.toString()}%",
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          backgroundColor: AppColor.coreColor,
                        ),
                      ),
                    Row(
                      children: [
                        Expanded(
                          child: Row(
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
                        ),
                        Text(
                          "\$${NumberHelper.shortenedDouble(product.price!)}  ",
                          style: GoogleFonts.robotoSlab(
                            color: product.discount != 0
                                ? Colors.black38
                                : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            decoration: product.discount != 0
                                ? TextDecoration.lineThrough
                                : null,
                            decorationStyle: product.discount != 0
                                ? TextDecorationStyle.solid
                                : null,
                            decorationThickness:
                                product.discount != 0 ? 2.0 : null,
                            decorationColor:
                                product.discount != 0 ? Colors.black38 : null,
                          ),
                        ),
                        if (product.discount != 0)
                          Text(
                            "  ${NumberHelper.shortenedDouble(product.price! - (product.price! * product.discount! / 100))}VNĐ",
                            style: GoogleFonts.robotoSlab(
                              fontSize: 18,
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
      ),
    );
  }

  Widget _buildCheckout(w, h) {
    return Container(
      width: double.infinity,
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Số lượng : ${widget.con.storeController.itemCounter.toString()} ",
            style: GoogleFonts.robotoSlab(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: w * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: widget.con.productInCart.isNotEmpty
                  ? Border.all(
                      color: AppColor.coreColor,
                      width: 2,
                    )
                  : null,
            ),
            child: Row(
              children: [
                widget.con.productInCart.isNotEmpty
                    ? Flexible(
                        child: Container(
                          alignment: Alignment.center,
                          child: Text(
                            widget.con.productInCart.isNotEmpty
                                ? "${NumberHelper.shortenedDouble(widget.con.totalPrice.value)}VNĐ"
                                : "",
                            style: GoogleFonts.robotoSlab(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Container(
                    height: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    decoration: BoxDecoration(
                      color: widget.con.productInCart.isNotEmpty
                          ? AppColor.coreColor
                          : AppColor.secondaryColor,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: GestureDetector(
                      onTap: () => widget.con.goToCheckout(),
                      child: Text(
                        "Mua ngay",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSlab(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                        ),
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
