import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/helpers/number_helper.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/checkout/checkout_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:math' as math;

class CheckoutPage extends StatefulWidget {
  CheckoutPage({super.key});

  CheckoutController con = Get.put(CheckoutController());

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final controller = PageController();
  int currentIndex = 0;
  List<dynamic> dropdownItems = [
    {'name': 'Visa', 'icon': 'assets/images/visa_payment.png'},
    {'name': 'Momo', 'icon': 'assets/images/momo_payment.png'},
  ];
  String dropdownValue = 'Visa';
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: h * 0.03,
            ),
            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: w * 0.2,
                    alignment: Alignment.center,
                    child: currentIndex == 0 || currentIndex == 1
                        ? GestureDetector(
                            onTap: () => Get.back(),
                            child: const FaIcon(
                              FontAwesomeIcons.x,
                              size: 25,
                            ),
                          )
                        : Container(),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 25 - 7.5,
                          left: 29,
                          child: Container(
                            width: 44,
                            height: 10,
                            color: const Color(0xFFD8D8D8),
                          ),
                        ),
                        Positioned(
                          top: 25 - 7.5,
                          left: 29,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                            width:
                                currentIndex == 1 || currentIndex == 2 ? 44 : 1,
                            height: 10,
                            color: currentIndex == 2
                                ? const Color(0xFFff4f5a)
                                : const Color(0xFFFE9C5E),
                          ),
                        ),
                        Positioned(
                          top: 25 - 7.5,
                          right: 29,
                          child: Container(
                            width: 44,
                            height: 10,
                            color: const Color(0xFFD8D8D8),
                          ),
                        ),
                        Positioned(
                          top: 25 - 7.5,
                          left: 30 + 40 + 29,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeIn,
                            width: currentIndex == 2 ? 44 : 1,
                            height: 10,
                            color: currentIndex == 2
                                ? const Color(0xFFff4f5a)
                                : const Color(0xFFFE9C5E),
                          ),
                        ),
                        SmoothPageIndicator(
                          controller: controller,
                          count: 3,
                          effect: JumpingDotEffect(
                            activeDotColor: currentIndex == 2
                                ? const Color(0xFFff4f5a)
                                : const Color(0xFFFE9C5E),
                            // verticalOffset: 15,
                            dotColor: currentIndex == 2
                                ? const Color(0xFFff4f5a)
                                : const Color(0xFFD8D8D8),
                            dotHeight: 30,
                            dotWidth: 30,
                            spacing: 40,
                          ),
                        ),
                        Positioned(
                          top: 5,
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: currentIndex == 0
                                ? const EdgeInsets.only(top: 40)
                                : const EdgeInsets.all(0),
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: currentIndex == 2
                                  ? const Color(0xFFff4f5a)
                                  : const Color(0xFFFE9C5E),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const FaIcon(
                              FontAwesomeIcons.check,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        if (currentIndex == 2)
                          Positioned(
                            top: 5,
                            right: 70,
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFff4f5a),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        if (currentIndex == 2)
                          Positioned(
                            top: 5,
                            right: 0,
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: const Color(0xFFff4f5a),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const FaIcon(
                                FontAwesomeIcons.check,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w * 0.2,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: h * 0.04,
            ),
            Expanded(
              child: PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller,
                children: [
                  _buildPageView1(w, h),
                  _buildPageView2(w, h),
                  _buildPageView3(w, h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPageView1(w, h) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Text(
              "CART",
              style: GoogleFonts.aleo(
                fontSize: w * 0.07,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: widget.con.productInCart.length,
                itemBuilder: (context, index) =>
                    _buildSingleItem(widget.con.productInCart[index]),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(40),
              child: Divider(
                height: 1,
                color: AppColor.secondaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: GoogleFonts.robotoSlab(
                      color: AppColor.secondaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${NumberHelper.shortenedDouble(widget.con.totalPrice.value)}",
                    style: GoogleFonts.robotoSlab(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: h * 0.08,
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
              child: Row(
                children: [
                  Bounce(
                    duration: const Duration(milliseconds: 200),
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              // backgroundColor: Colors.transparent,
                              content: Container(
                                width: w * 0.8,
                                height: h * 0.7,
                                decoration: const BoxDecoration(
                                    // color: Colors.red,
                                    ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Voucher",
                                        style: GoogleFonts.robotoSlab(
                                          fontSize: 25,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ...widget.con.userVoucher.map(
                                        (voucher) {
                                          return Bounce(
                                            duration: const Duration(
                                                milliseconds: 200),
                                            onPressed: () {
                                              widget.con.useVoucher(voucher);
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 20),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              decoration: BoxDecoration(
                                                // color: Colors.greenAccent,
                                                border: Border.all(
                                                  width: 3,
                                                  color: Colors.black26,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: w * 0.3,
                                                    height: 200,
                                                    child: Image.network(
                                                      voucher.image!,
                                                      fit: BoxFit.contain,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 30,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      children: [
                                                        Text(
                                                          "Discount",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .robotoSlab(
                                                            fontSize: 18,
                                                          ),
                                                        ),
                                                        Text(
                                                          "${voucher.discount}%",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .robotoSlab(
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Expired in ${voucher.endDate!.difference(DateTime.now()).inDays} days",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: GoogleFonts
                                                              .robotoSlab(
                                                            fontSize: 18,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      // Expanded(
                                      //   child: SizedBox(),
                                      // ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: const [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 10,
                              color: Colors.black12,
                            )
                          ]),
                      child: Image.asset(
                        "assets/icons/icon_voucher.png",
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          currentIndex = 1;
                        });
                        controller.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColor.coreColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Continue",
                                style: GoogleFonts.robotoSlab(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const FaIcon(
                                FontAwesomeIcons.arrowRightLong,
                                color: Colors.white,
                                size: 25,
                              ),
                            ],
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
      ),
    );
  }

  Widget _buildSingleItem(Product product) {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(
        bottom: 30,
      ),
      padding: const EdgeInsets.only(left: 5, top: 10),
      child: Row(
        children: [
          Container(
            width: 150,
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  // color: AppColor.coreColor,
                  spreadRadius: 0.5,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              product.image!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 30,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name!,
                    style: GoogleFonts.robotoSlab(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "\$${NumberHelper.shortenedDouble(product.discount != 0 ? product.price! * ((100 - product.discount!) / 100) : product.price!)}",
                        style: GoogleFonts.robotoSlab(
                          color: Colors.black.withOpacity(0.6),
                          fontSize: 22,
                          // fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "x${product.quantity!.toString()}",
                          style: GoogleFonts.robotoSlab(
                            color: Colors.black.withOpacity(0.6),
                            // fontSize: ,
                            fontWeight: FontWeight.w600,
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
    );
  }

  Widget _buildPageView2(w, h) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Text(
            "PAYMENT",
            style: GoogleFonts.aleo(
              fontSize: w * 0.07,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: h * 0.05,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Name",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.infinity,
                      height: 50,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(left: 25),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        border: Border.all(
                          color: AppColor.secondaryColor,
                        ),
                      ),
                      child: Text(
                        widget.con.userSession.name!,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Phone",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => TextField(
                        controller: widget.con.phoneController,
                        maxLength: 10,
                        keyboardType: TextInputType.text,
                        onChanged: (newPhone) =>
                            widget.con.checkPhoneValid(newPhone),
                        decoration: InputDecoration(
                          suffixIcon: widget.con.isPhoneComplete.value
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : null,
                          hintText: "09********",
                          hintStyle: GoogleFonts.robotoSlab(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Address",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Obx(
                      () => TextField(
                        controller: widget.con.addressController,
                        keyboardType: TextInputType.text,
                        onChanged: (newAddress) =>
                            widget.con.checkAddressValid(newAddress),
                        decoration: InputDecoration(
                          suffixIcon: widget.con.isAddressComplete.value
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                )
                              : null,
                          hintText: "To",
                          hintStyle: GoogleFonts.robotoSlab(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 25,
                            vertical: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25),
                      child: Text(
                        "Payment Method",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                                isExpanded: true,
                                icon: const FaIcon(
                                  FontAwesomeIcons.caretDown,
                                  color: Colors.black,
                                  size: 20,
                                ),
                                value: dropdownValue,
                                items: _dropdownItems(dropdownItems),
                                onChanged: (option) {
                                  setState(() {
                                    dropdownValue = option!;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                        Obx(
                          () => AnimatedOpacity(
                            opacity: widget.con.isPhoneComplete.value == true &&
                                    widget.con.isAddressComplete.value == true
                                ? 1
                                : 0.3,
                            duration: const Duration(milliseconds: 1000),
                            child: GestureDetector(
                              onTap: () async {
                                await widget.con
                                    .makePayment(context, controller)
                                    .then((value) {
                                  setState(() {
                                    currentIndex = 2;
                                  });
                                });
                              },
                              child: const FaIcon(
                                FontAwesomeIcons.creditCard,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: h * 0.08,
            margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  currentIndex = 0;
                });
                controller.previousPage(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: w * 0.15,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Transform.rotate(
                        angle: math.pi,
                        child: const FaIcon(
                          FontAwesomeIcons.arrowRightFromBracket,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        "Back",
                        style: GoogleFonts.robotoSlab(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageView3(w, h) {
    return Column(
      children: [
        Flexible(
          child: Image.asset(
            "assets/images/background_order_success.png",
            fit: BoxFit.contain,
          ),
        ),
        SizedBox(
          height: h * 0.01,
        ),
        Text(
          "Your order is accepted !",
          style: GoogleFonts.robotoSlab(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(
          height: h * 0.03,
        ),
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            "Have patience you can collect your order as soon as possible",
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoSlab(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(
          height: h * 0.04,
        ),
        GestureDetector(
          onTap: () => widget.con.goToHomePage(),
          child: Container(
            width: double.infinity,
            height: 60,
            margin: const EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              color: const Color(0xFFff4f5a),
              borderRadius: BorderRadius.circular(50),
            ),
            alignment: Alignment.center,
            child: Text(
              "Need more? Let's do again",
              style: GoogleFonts.robotoSlab(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<DropdownMenuItem<dynamic>> _dropdownItems(List<dynamic> items) {
    List<DropdownMenuItem<dynamic>> list = [];
    for (var element in items) {
      list.add(
        DropdownMenuItem(
          value: element['name'],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 5,
              ),
              Text(
                element['name'],
                style: GoogleFonts.robotoSlab(
                  fontSize: 17,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Image.asset(
                    element['icon'],
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
            ],
          ),
        ),
      );
    }
    return list;
  }
}
