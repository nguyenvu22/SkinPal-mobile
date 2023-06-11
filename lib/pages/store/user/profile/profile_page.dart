import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/main.dart';
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
          padding:
              EdgeInsets.only(left: 40, right: 40, top: h * 0.06, bottom: 30),
          child: Column(
            children: [
              Text(
                "Hồ sơ",
                style: GoogleFonts.robotoSlab(
                  color: AppColor.secondaryColor,
                  fontSize: w * 0.08,
                ),
              ),
              SizedBox(
                height: h * 0.04,
              ),
              _infoBox(w, h),
              SizedBox(
                height: h * 0.04,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Obx(
                    () => Column(
                      children: [
                        _optionChoice(
                          "assets/icons/icon_profile_person.png",
                          "Thông tin cá nhân",
                          true,
                          () => Get.toNamed("/profileCustomization"),
                        ),
                        _optionChoice(
                          "assets/icons/icon_profile_favorite.png",
                          "Ưa thích",
                          true,
                          () => Get.toNamed("/favorite"),
                        ),
                        _optionChoice(
                          "assets/icons/icon_survey.png",
                          "Khảo sát",
                          true,
                          () => Get.toNamed("/survey"),
                        ),
                        _optionChoice(
                          "assets/icons/icon_routine.png",
                          "Liệu trình",
                          true,
                          () => Get.toNamed("/routine"),
                        ),
                        if (con.userSession.value.isPremium == false)
                          _optionChoice(
                            "assets/icons/icon_premium.png",
                            "Nâng cấp premium",
                            false,
                            () => showDialog(
                                context: context,
                                builder: (_) => _diaLogPremium(w, h, context)),
                          ),
                        _optionChoice(
                            "assets/icons/icon_profile_shopping_bag.png",
                            "Giỏ hàng",
                            true, () {
                          final navigationState = navigationKey.currentState!;
                          navigationState.setPage(0);
                        }),
                        _optionChoice("assets/icons/icon_profile_chat.png",
                            "Chat với chuyên gia", true, () {
                          Get.toNamed('videoChat');
                        }),
                        _optionChoice(
                            "assets/icons/icon_logout.png", "Đăng xuất", false,
                            () {
                          GetStorage().remove('user');
                          Get.offNamedUntil("/login", (route) => false);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _diaLogPremium(double w, double h, context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      content: SizedBox(
        width: w * 0.6,
        height: h * 0.45,
        child: Stack(
          children: [
            Positioned(
              top: 20 + w * 0.1,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 40 + w * 0.1,
                  left: 30,
                  right: 30,
                  bottom: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text(
                        "Trở thành thành viên vip để mở khóa",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 17,
                        ),
                      ),
                    ),
                    Text(
                      "● Giá ưu đãi",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "● Chat",
                      style: GoogleFonts.robotoSlab(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          "Chỉ với 10.000VNĐ/month",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.robotoSlab(
                            color: AppColor.coreColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Bounce(
                        duration: const Duration(milliseconds: 200),
                        onPressed: () {
                          con.makePayment(context);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            "Kích hoạt",
                            style: GoogleFonts.robotoSlab(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                      color: AppColor.coreColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 1,
                          blurRadius: 10,
                          color: Colors.black12,
                        )
                      ]),
                  child: Image.asset(
                    "assets/images/go_to_premium.png",
                    width: w * 0.2,
                    height: w * 0.2,
                  ),
                ),
              ),
            ),
          ],
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
              color: con.userSession.value.isPremium!
                  ? AppColor.coreColor.withOpacity(0.3)
                  : Colors.black.withOpacity(0.1),
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
                  Stack(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 20),
                        width: w * 0.25,
                        height: w * 0.25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 1,
                              blurRadius: 15,
                              color: con.userSession.value.isPremium!
                                  ? AppColor.coreColor
                                  : Colors.black12,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          backgroundImage: con.userSession.value.avatar != null
                              ? NetworkImage(
                                  con.userSession.value.avatar!,
                                )
                              : const AssetImage(
                                  "assets/images/empty_image.png",
                                ) as ImageProvider,
                        ),
                      ),
                      if (con.userSession.value.isPremium != null)
                        if (con.userSession.value.isPremium == true)
                          Positioned(
                            right: 20,
                            bottom: 0,
                            child: SizedBox(
                              width: w * 0.1,
                              height: w * 0.1,
                              child: Image.asset(
                                "assets/images/premium_user.png",
                              ),
                            ),
                          ),
                    ],
                  ),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: "Xin chào,\n",
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
