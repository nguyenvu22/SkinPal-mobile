import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/store/cart/cart_page.dart';
import 'package:skinpal/pages/store/chat/chat_page.dart';
import 'package:skinpal/pages/store/search/search_page.dart';
import 'package:skinpal/pages/store/home/home_page.dart';
import 'package:skinpal/pages/store/store_controller.dart';
import 'package:skinpal/pages/store/user/profile/profile_page.dart';

class StorePage extends StatefulWidget {
  StorePage({super.key});

  StoreController con = Get.put(StoreController());

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  //To set the current Page
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  // Place where you want to go to specific Page:
  // final navigationState = navigationKey.currentState!;
  // navigationState.setPage(0);

  int index = 2;

  late final screens = [
    CartPage(),
    SearchPage(),
    HomePage(navigationKey: navigationKey),
    ProfilePage(navigationKey: navigationKey),
    ChatPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = <Widget>[
      Obx(
        () => Stack(
          children: [
            Image.asset(
              "assets/icons/icon_shopping_bag.png",
              width: 30,
              height: 30,
              color: Colors.white,
            ),
            if (widget.con.itemCounter.value > 0 && index != 0)
              Positioned(
                right: 0,
                bottom: 0,
                child: Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.redAccent,
                  ),
                  child: Text(
                    textAlign: TextAlign.center,
                    widget.con.itemCounter.value > 9
                        ? "9+"
                        : widget.con.itemCounter.value.toString(),
                    style: GoogleFonts.robotoSlab(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
      Image.asset(
        "assets/icons/icon_search.png",
        width: 30,
        height: 30,
        color: Colors.white,
      ),
      Image.asset(
        "assets/icons/icon_home.png",
        width: 30,
        height: 30,
        color: Colors.white,
      ),
      Image.asset(
        "assets/icons/icon_person.png",
        width: 30,
        height: 30,
        color: Colors.white,
      ),
      Image.asset(
        "assets/icons/icon_chat.png",
        width: 30,
        height: 30,
        color: Colors.white,
      ),
    ];

    return Scaffold(
      extendBody: true,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0.0,
              end: 1.0,
            ).animate(animation),
            child: child,
          );
        },
        child: screens[index],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: navigationKey,
        items: items,
        index: index,
        height: 70,
        backgroundColor: Colors.transparent,
        color: AppColor.coreColor,
        buttonBackgroundColor: const Color.fromARGB(255, 255, 85, 0),
        animationCurve: Curves.easeInOut,
        animationDuration: const Duration(milliseconds: 600),
        onTap: (index) => setState(() {
          this.index = index;
        }),
      ),
    );
  }
}
