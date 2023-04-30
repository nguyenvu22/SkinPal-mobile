import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/store/user/update/update_profile_controller.dart';

class UpdateProfilePage extends StatefulWidget {
  UpdateProfilePage({super.key});

  UpdateProfileController con = Get.put(UpdateProfileController());

  @override
  State<UpdateProfilePage> createState() => _UpdateProfilePageState();
}

class _UpdateProfilePageState extends State<UpdateProfilePage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Image.asset(
                "assets/images/blur_background.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                  sigmaX: 5,
                  sigmaY: 5,
                ),
                child: const SizedBox(),
              ),
            ),
            Center(
              child: SizedBox(
                height: h * 0.85,
                width: w * 0.8,
                child: Column(
                  children: [
                    _infoBox(w, h),
                    Expanded(
                      child: _updateForm(w, h),
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

  Widget _infoBox(w, h) {
    return Stack(
      children: [
        Container(
          height: h * 0.22,
          padding: const EdgeInsets.all(30),
          margin: EdgeInsets.only(bottom: w * 0.06),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                spreadRadius: 5,
                blurRadius: 25,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              GestureDetector(
                onTap: () => widget.con.showAlertDialog(context),
                child: Container(
                  margin: const EdgeInsets.only(right: 20),
                  width: w * 0.28,
                  height: h * 0.14,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColor.secondaryColor,
                      width: 1.0,
                    ),
                  ),
                  child: GetBuilder<UpdateProfileController>(
                    builder: (value) => CircleAvatar(
                      backgroundColor: Colors.black12,
                      backgroundImage: widget.con.imageFile != null
                          ? FileImage(widget.con.imageFile!)
                          : widget.con.userSession.avatar != null
                              ? NetworkImage(
                                  widget.con.userSession.avatar!,
                                )
                              : const AssetImage(
                                  "assets/images/empty_image.png",
                                ) as ImageProvider,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      widget.con.userSession.name!,
                      style: GoogleFonts.robotoSlab(
                        color: AppColor.coreColor,
                        fontSize: w * 0.05,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 10,
          right: 80,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.coreColor,
            ),
            child: Text(
              "Verify",
              style: GoogleFonts.robotoSlab(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10,
          right: 30,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.coreColor,
            ),
            child: Image.asset(
              "assets/icons/icon_face_scanning.png",
              color: Colors.white,
              width: 20,
              height: 20,
            ),
          ),
        ),
      ],
    );
  }

  Widget _updateForm(w, h) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(45),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 25,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextField(
              enabled: false,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: widget.con.userSession.email,
                hintStyle: GoogleFonts.robotoSlab(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                labelText: "Email",
                labelStyle: GoogleFonts.robotoSlab(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: widget.con.nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: widget.con.userSession.name,
                hintStyle: GoogleFonts.robotoSlab(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                labelText: "Name",
                labelStyle: GoogleFonts.robotoSlab(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child:
                // Obx(() =>
                Container(
              width: double.infinity,
              height: 55,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColor.secondaryColor,
                ),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.con.dobController,
                      style: GoogleFonts.robotoSlab(
                        color: AppColor.inactiveColor,
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                      left: 50,
                      right: 20,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          width: 1.5,
                          color: AppColor.secondaryColor.withOpacity(0.2),
                        ),
                      ),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.parse(
                            widget.con.dobController,
                          ),
                          firstDate: DateTime(1975),
                          lastDate: DateTime.now(),
                        ).then(
                          (value) => setState(() {
                            widget.con.dobController =
                                value.toString().split(" ")[0];
                          }),
                        );
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.calendarDays,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: widget.con.passwordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "***",
                hintStyle: GoogleFonts.robotoSlab(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                labelText: "New-Password",
                labelStyle: GoogleFonts.robotoSlab(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: TextField(
              controller: widget.con.confirmPasswordController,
              keyboardType: TextInputType.text,
              obscureText: true,
              decoration: InputDecoration(
                hintText: "***",
                hintStyle: GoogleFonts.robotoSlab(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                labelText: "Confirm-Password",
                labelStyle: GoogleFonts.robotoSlab(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 23,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 2,
                        color: AppColor.coreColor,
                      ),
                    ),
                    child: Text(
                      "Back",
                      style: GoogleFonts.robotoSlab(
                        color: AppColor.coreColor,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => widget.con.modify(),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: AppColor.coreColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      "Save",
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
