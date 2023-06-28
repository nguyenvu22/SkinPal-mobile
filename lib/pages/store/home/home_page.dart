import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/helpers/number_helper.dart';
import 'package:skinpal/models/blog.dart';
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
              // CarouselSlider.builder(
              //   // itemCount: banners.length,
              //   itemCount: banners.length,
              //   itemBuilder: (content, index, realIndex) =>
              //       _buildImage(banners[index], index),
              //   options: CarouselOptions(
              //     // autoPlay: true,
              //     height: h * 0.3,
              //     onPageChanged: (index, reason) =>
              //         setState(() => activeIndex = index),
              //   ),
              // ),
              FutureBuilder(
                  future: widget.con.getAllBlog(),
                  builder: (context, AsyncSnapshot<List<Blog>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.isNotEmpty) {
                        return CarouselSlider.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (content, index, realIndex) =>
                              _buildBlogItem(snapshot.data![index], h),
                          options: CarouselOptions(
                            // autoPlay: true,
                            height: h * 0.3,
                            onPageChanged: (index, reason) =>
                                setState(() => activeIndex = index),
                          ),
                        );
                      }
                      return Container();
                    }
                    return Container();
                  }),
              SizedBox(
                height: h * 0.02,
              ),
              _buildIndicator(),
              SizedBox(
                height: h * 0.03,
              ),
              _buildProductByCategory(w, h),
              // _buildProductByCategory(w, h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBlogItem(Blog blog, h) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Bounce(
        duration: const Duration(milliseconds: 200),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (_) {
                return SizedBox(
                  height: h * 0.7,
                  child: Column(
                    children: [
                      Image.network(
                        blog.image!,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 10, left: 30, right: 30),
                          child: Text(
                            blog.description!,
                            style: GoogleFonts.roboto(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              });
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 10,
                    color: Colors.black45,
                  )
                ],
              ),
              width: double.infinity,
              height: double.infinity,
              child: Image.network(
                blog.image!,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(
              top: 160,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.all(15),
                decoration: const BoxDecoration(
                  color: Colors.black38,
                ),
                child: Text(
                  blog.title!,
                  style: GoogleFonts.robotoSlab(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
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
      count: 5,
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
                "Gợi ý sản phẩm",
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
                  "Xem tất cả",
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
                          "Đề xuất",
                          style: GoogleFonts.robotoSlab(),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Tab(
                          child: Text(
                            "Xu hướng",
                            style: GoogleFonts.robotoSlab(),
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          "Giảm giá",
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
                SizedBox(
                  width: double.infinity,
                  height: 300,
                  child: TabBarView(
                    children: [
                      // Icon(Icons.access_alarm),
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        margin: const EdgeInsets.only(top: 20),
                        child: FutureBuilder(
                          future: widget.con.getProductsWithAll(),
                          builder:
                              (context, AsyncSnapshot<List<Product>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data!.isNotEmpty) {
                                return ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: 5,
                                  itemBuilder: (context, index) =>
                                      _buildProductItem(
                                          snapshot.data![index + 1]),
                                );
                              }
                              return Container();
                            }
                            return Container();
                          },
                        ),
                      ),
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

  Widget _buildProductItem(Product product) {
    return Container(
      width: 300,
      // height: 250,
      // padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // border: Border.all(
        //   width: 2,
        //   color: Colors.black87,
        // ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            spreadRadius: 1,
            blurRadius: 5,
            color: Colors.black26,
          ),
        ],
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                // boxShadow: [
                //   BoxShadow(
                //     spreadRadius: 1,
                //     blurRadius: 10,
                //     color: Colors.black38,
                //   ),
                // ],
              ),
              child: Image.network(
                product.image!,
                width: 150,
                height: 150,
                fit: BoxFit.contain,
              ),
            ),
          ),
          if (product.discount! != 0)
            Positioned(
              top: 10,
              right: 20,
              child: Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                // padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: AppColor.coreColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  "-${product.discount!.toString()}%",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 120,
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: Column(
                children: [
                  Text(
                    product.name!,
                    maxLines: 2,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "${NumberHelper.shortenedDouble(product.price!)} ${product.discount != 0 ? '' : 'VNĐ'}",
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: GoogleFonts.robotoSlab(
                          color: product.discount != 0
                              ? Colors.white54
                              : AppColor.coreColor,
                          fontSize: 18,
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
                              product.discount != 0 ? Colors.white60 : null,
                        ),
                      ),
                      if (product.discount != 0)
                        Text(
                          " ${NumberHelper.shortenedDouble(product.price! - (product.price! * product.discount! / 100))} VNĐ",
                          style: GoogleFonts.robotoSlab(
                            color: AppColor.coreColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
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
}
