import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/store/user/profile/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  // const ProfilePage({super.key});

  ProfileController con = Get.put(ProfileController());

  final GlobalKey<CurvedNavigationBarState> navigationKey;
  ProfilePage({Key? key, required this.navigationKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.only(left: 40, right: 40, top: h * 0.06),
          child: Column(
            children: [
              Text(
                "Profile",
                style: GoogleFonts.robotoSlab(
                  color: AppColor.secondaryColor,
                  fontSize: w * 0.1,
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              _infoBox(w, h),
              SizedBox(
                height: h * 0.04,
              ),
              _optionChoice(
                "assets/images/profile_person.png",
                "Your Profile",
                true,
                () => Get.toNamed("/profileCustomization"),
              ),
              _optionChoice(
                "assets/images/profile_favorite.png",
                "My favorites",
                true,
                () => Get.toNamed("/favorite"),
              ),
              _optionChoice(
                "assets/images/icon_routine.png",
                "My Routine",
                true,
                () => Get.toNamed("/routine"),
              ),
              _optionChoice("assets/images/profile_shopping_bag.png",
                  "My Shopping Bag", true, () {
                final navigationState = navigationKey.currentState!;
                navigationState.setPage(0);
              }),
              _optionChoice("assets/images/logout.png", "Logout", false, () {
                GetStorage().remove('user');
                Get.offNamedUntil("/login", (route) => false);
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoBox(w, h) {
    return Obx(
      () => Container(
        height: h * 0.25,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 15,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.hardEdge,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 20),
                    width: w * 0.3,
                    height: h * 0.13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage: con.userSession.value.avatar != null
                          ? NetworkImage(
                              con.userSession.value.avatar!,
                            )
                          : const AssetImage(
                              "assets/images/empty_image.png",
                            ) as ImageProvider,
                    ),
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "Hello,\n",
                        style: GoogleFonts.robotoSlab(
                          color: AppColor.secondaryColor,
                          fontSize: w * 0.05,
                          fontWeight: FontWeight.w600,
                        ),
                        children: [
                          TextSpan(
                            text: con.userSession.value.name!,
                            style: GoogleFonts.robotoSlab(
                              color: AppColor.coreColor,
                              fontSize: w * 0.08,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     GestureDetector(
            //       onTap: () => Get.toNamed("/profileCustomization"),
            //       child: Container(
            //         decoration: BoxDecoration(
            //           color: AppColor.coreColor,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         padding:
            //             EdgeInsets.symmetric(horizontal: w * 0.16, vertical: 12),
            //         child: Text(
            //           "Edit Account",
            //           style: GoogleFonts.robotoSlab(
            //               color: Colors.white,
            //               fontSize: 18,
            //               fontWeight: FontWeight.w600),
            //         ),
            //       ),
            //     ),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            //   decoration: BoxDecoration(
            //     color: AppColor.coreColor.withOpacity(0.5),
            //     border: Border.all(
            //       width: 2,
            //       color: AppColor.coreColor,
            //     ),
            //     borderRadius: BorderRadius.circular(50),
            //   ),
            //   child: Image.asset("assets/images/medal.png"),
            // ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }

  Widget _optionChoice(icon, name, isContinuos, func) {
    return GestureDetector(
      onTap: func,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: AppColor.secondaryColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15),
              child: Image.asset(
                icon,
                color: AppColor.coreColor,
                fit: BoxFit.cover,
                width: 30,
                height: 30,
              ),
            ),
            Text(
              name,
              style: GoogleFonts.robotoSlab(
                  color: AppColor.secondaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500),
            ),
            Expanded(child: Container()),
            if (isContinuos)
              const Icon(
                Icons.arrow_forward_ios,
                color: AppColor.secondaryColor,
              ),
          ],
        ),
      ),
    );
  }
}
