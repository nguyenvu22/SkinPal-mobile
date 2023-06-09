import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/helpers/number_helper.dart';
import 'package:skinpal/models/category.dart';
import 'package:skinpal/models/product.dart';
import 'package:skinpal/pages/store/search/search_controller.dart';
import 'package:skinpal/widgets/no_data_widget.dart';
import 'package:flutter_bounce/flutter_bounce.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  SearchController con = Get.put(SearchController());

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: h * 0.02,
            ),
            _buildFeildSearch(),
            _buildCategoryOption(w, h),
          ],
        ),
      ),
    );
  }

  Widget _buildFeildSearch() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextField(
        // Dont have to have parentless since this event will fire every time something inside the text
        onChanged: widget.con.onTextChanging,
        decoration: InputDecoration(
          hintText: "Tìm kiếm...",
          hintStyle: GoogleFonts.robotoSlab(
            color: AppColor.secondaryColor,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          prefixIcon: const Icon(
            Icons.search,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: AppColor.secondaryColor,
              width: 2,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(
              color: AppColor.coreColor,
              width: 2,
            ),
          ),
        ),
        style: GoogleFonts.robotoSlab(
          fontSize: 20,
        ),
      ),
    );
  }

  Widget _buildCategoryOption(w, h) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      height: h * 0.8,
      child: Obx(
        () => DefaultTabController(
          length: widget.con.categories.length + 1,
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Loại",
                    style: GoogleFonts.robotoSlab(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Theme(
                      data: ThemeData().copyWith(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                      ),
                      child: TabBar(
                        isScrollable: true,
                        indicatorColor: AppColor.coreColor,
                        unselectedLabelColor: AppColor.secondaryColor,
                        unselectedLabelStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        labelColor: AppColor.coreColor,
                        labelStyle: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        tabs: [
                          Tab(
                            child: Text(
                              "Tất cả",
                              style: GoogleFonts.robotoSlab(),
                            ),
                          ),
                          ...List<Widget>.generate(
                            widget.con.categories.length,
                            (index) => Tab(
                              child: Text(
                                widget.con.categories[index].name ?? '',
                                style: GoogleFonts.robotoSlab(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FutureBuilder(
                      future: widget.con
                          .getProductsWithAll(widget.con.searchText.value),
                      builder:
                          (context, AsyncSnapshot<List<Product>> snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!.isNotEmpty) {
                            return SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 25,
                                  mainAxisSpacing: 35,
                                  mainAxisExtent: 280,
                                ),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: snapshot.data!.length,
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                  top: 30,
                                ),
                                itemBuilder: (_, index) =>
                                    _buildProductItem(snapshot.data![index]),
                              ),
                            );
                          } else {
                            return NoDataWidget(
                              text: 'Không tìm thấy sản phẩm',
                              img: "assets/images/empty_search_item.png",
                            );
                          }
                        } else {
                          return NoDataWidget(
                            text: 'Không tìm thấy sản phẩm',
                            img: "assets/images/empty_search_item.png",
                          );
                        }
                      },
                    ),
                    ...widget.con.categories.map(
                      (Category category) => FutureBuilder(
                        future: widget.con.getProductsWithCate(
                            category.id ?? 0, widget.con.searchText.value),
                        builder:
                            (context, AsyncSnapshot<List<Product>> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.isNotEmpty) {
                              return SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: GridView.builder(
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 25,
                                    mainAxisSpacing: 35,
                                    mainAxisExtent: 280,
                                  ),
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data!.length,
                                  padding: const EdgeInsets.only(
                                    left: 15,
                                    right: 15,
                                    top: 30,
                                  ),
                                  itemBuilder: (_, index) =>
                                      _buildProductItem(snapshot.data![index]),
                                ),
                              );
                            } else {
                              return NoDataWidget(
                                text: 'Không tìm thấy sản phẩm',
                                img: "assets/images/empty_search_item.png",
                              );
                            }
                          } else {
                            return NoDataWidget(
                              text: 'Không tìm thấy sản phẩm',
                              img: "assets/images/empty_search_item.png",
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          child: Obx(
            () => Stack(
              children: [
                GestureDetector(
                  onTap: () => widget.con.goToProductDetail(product),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 3,
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: FadeInImage(
                        height: 180,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder:
                            const AssetImage("assets/images/loading_image.png"),
                        image: product.image != null
                            ? NetworkImage(product.image!)
                            : const AssetImage(
                                    "assets/images/loading_image.png")
                                as ImageProvider,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 20,
                  right: 20,
                  child: GestureDetector(
                    onTap: () => widget.con.favorite(product.id!),
                    child: widget.con.favoriteList.contains(product.id)
                        ? const FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.red,
                            size: 25,
                          )
                        : const FaIcon(
                            FontAwesomeIcons.heart,
                            size: 25,
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
          ),
          child: Text(
            product.name!,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: GoogleFonts.robotoSlab(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          child: Row(
            children: [
              Text(
                "${NumberHelper.shortenedDouble(product.price!)}${product.discount != 0 ? '' : 'VNĐ'} ",
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: GoogleFonts.robotoSlab(
                  color: product.discount != 0
                      ? Colors.black38
                      : AppColor.coreColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration:
                      product.discount != 0 ? TextDecoration.lineThrough : null,
                  decorationStyle:
                      product.discount != 0 ? TextDecorationStyle.solid : null,
                  decorationThickness: product.discount != 0 ? 2.0 : null,
                  decorationColor:
                      product.discount != 0 ? Colors.black38 : null,
                ),
              ),
              if (product.discount != 0)
                const FaIcon(
                  FontAwesomeIcons.arrowRight,
                  size: 15,
                  color: Colors.black38,
                ),
              if (product.discount != 0)
                Text(
                  " ${NumberHelper.shortenedDouble(product.price! - (product.price! * product.discount! / 100))}VNĐ",
                  style: GoogleFonts.robotoSlab(
                    color: AppColor.coreColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Bounce(
                    duration: const Duration(milliseconds: 200),
                    onPressed: () => widget.con.addToCart(product),
                    child: const FaIcon(
                      FontAwesomeIcons.cartShopping,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
