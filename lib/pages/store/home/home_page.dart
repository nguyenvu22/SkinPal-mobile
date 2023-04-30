import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/store/home/home_controller.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  // const HomePage({super.key});

  final GlobalKey<CurvedNavigationBarState> navigationKey;

  HomeController con = Get.put(HomeController());

  HomePage({Key? key, required this.navigationKey}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;

  final banners = [
    "assets/images/banner1.png",
    "assets/images/banner2.png",
    "assets/images/banner3.png",
    "assets/images/banner4.png",
  ];

  late List<Product> products = [
    Product(
      id: 1,
      name: "Product 1",
      image: "image1.jpg",
      description: "This is product 1",
      price: 10.99,
      // instruction: "Use as directed",
      // avoidance: ["peanuts", "gluten"],
    ),
    Product(
      id: 2,
      name: "Product 2",
      image: "image2.jpg",
      description: "This is product 2",
      price: 20.99,
      // instruction: "Use as directed",
      // avoidance: ["dairy"],
    ),
    Product(
      id: 3,
      name: "Product 3",
      image: "image3.jpg",
      description: "This is product 3",
      price: 30.99,
      // instruction: "Use as directed",
      // avoidance: ["soy"],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              SizedBox(
                height: h * 0.03,
              ),
              CarouselSlider.builder(
                itemCount: banners.length,
                itemBuilder: (content, index, realIndex) =>
                    _buildImage(banners[index], index),
                options: CarouselOptions(
                  // autoPlay: true,
                  height: h * 0.3,
                  onPageChanged: (index, reason) =>
                      setState(() => activeIndex = index),
                ),
              ),
              SizedBox(
                height: h * 0.02,
              ),
              _buildIndicator(),
              SizedBox(
                height: h * 0.03,
              ),
              _buildProductByCategory(w, h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildImage(url, index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColor.coreColor.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 20,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Image.asset(
        url,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildIndicator() {
    return AnimatedSmoothIndicator(
      count: banners.length,
      activeIndex: activeIndex,
      effect: ExpandingDotsEffect(
        dotColor: AppColor.inactiveColor.withOpacity(0.3),
        activeDotColor: AppColor.coreColor,
        dotWidth: 15,
        dotHeight: 15,
        spacing: 10,
      ),
    );
  }

  Widget _buildProductByCategory(w, h) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * 0.05,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "Browse by Category",
                style: GoogleFonts.robotoSlab(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  final navigationState = widget.navigationKey.currentState!;
                  navigationState.setPage(1);
                },
                child: Text(
                  "View all",
                  style: GoogleFonts.robotoSlab(
                    color: AppColor.secondaryColor,
                    fontSize: 17,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 25,
          ),
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                Theme(
                  data: ThemeData().copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: TabBar(
                    tabs: [
                      Tab(
                        child: Text(
                          "Recommened",
                          style: GoogleFonts.robotoSlab(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Tab(
                          child: Text(
                            "Treding",
                            style: GoogleFonts.robotoSlab(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Sale",
                          style: GoogleFonts.robotoSlab(),
                        ),
                      ),
                    ],
                    isScrollable: true,
                    indicatorColor: Colors.transparent,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        width: 2,
                        color: AppColor.coreColor,
                      ),
                    ),
                    unselectedLabelColor: AppColor.secondaryColor,
                    unselectedLabelStyle: const TextStyle(
                      fontSize: 14,
                    ),
                    labelColor: AppColor.coreColor,
                    labelStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: TabBarView(
                    children: [
                      Icon(Icons.access_alarm),
                      Icon(Icons.radar),
                      Icon(Icons.qr_code),
                    ],
                  ),
                  // child: products.map((product) {
                  //   return Container();
                  // }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
