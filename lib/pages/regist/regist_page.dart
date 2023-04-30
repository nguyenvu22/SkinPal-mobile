import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/pages/regist/regist_controller.dart';

class RegistPage extends StatefulWidget {
  RegistController con = Get.put(RegistController());
  @override
  State<RegistPage> createState() => _RegistPageState();
}

class _RegistPageState extends State<RegistPage> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(
                top: h * 0.38,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: w * 0.1,
              ),
              child: Column(
                children: [
                  _inputEmail(),
                  const SizedBox(
                    height: 20,
                  ),
                  _inputName(),
                  const SizedBox(
                    height: 20,
                  ),
                  _inputPassword(),
                  const SizedBox(
                    height: 20,
                  ),
                  _inputConfirmPassword(),
                  const SizedBox(
                    height: 20,
                  ),
                  _inputDatePicker(),
                  const SizedBox(
                    height: 20,
                  ),
                  _buttonRegist(),
                  Expanded(
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      padding: const EdgeInsets.only(
                        bottom: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already a member?",
                            style: GoogleFonts.robotoSlab(
                              fontSize: 15,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Text(
                              "  Login",
                              style: GoogleFonts.robotoSlab(
                                color: const Color.fromARGB(255, 241, 119, 58),
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: h * 0.33,
              width: w,
              decoration: const BoxDecoration(
                color: AppColor.coreColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(120),
                ),
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 233, 126, 70),
                    AppColor.coreColor
                  ],
                  stops: [0.65, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Stack(
                children: [
                  Center(
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.white,
                            spreadRadius: 2,
                            blurRadius: 10,
                            // offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        onTap: () => widget.con.showAlertDialog(context),
                        //GetBuilder => State Management
                        child: GetBuilder<RegistController>(
                          builder: (controller) => CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage: widget.con.imageFile != null
                                ? FileImage(widget.con.imageFile!)
                                : const AssetImage(
                                    "assets/images/empty_user.png",
                                  ) as ImageProvider,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 30,
                    right: 30,
                    child: Text(
                      "Register",
                      style: GoogleFonts.robotoSlab(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
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

  Widget _inputEmail() {
    return TextField(
      controller: widget.con.emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        hintText: "Email",
        hintStyle: GoogleFonts.robotoSlab(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        labelText: "Email",
        labelStyle: GoogleFonts.robotoSlab(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget _inputName() {
    return TextField(
      controller: widget.con.nameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Name",
        hintStyle: GoogleFonts.robotoSlab(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        labelText: "Name",
        labelStyle: GoogleFonts.robotoSlab(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget _inputPassword() {
    return TextField(
      controller: widget.con.passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "***",
        hintStyle: GoogleFonts.robotoSlab(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        labelText: "Password",
        labelStyle: GoogleFonts.robotoSlab(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget _inputConfirmPassword() {
    return TextField(
      controller: widget.con.confirmPasswordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      decoration: InputDecoration(
        hintText: "***",
        hintStyle: GoogleFonts.robotoSlab(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
        labelText: "Confirm Password",
        labelStyle: GoogleFonts.robotoSlab(
          fontSize: 17,
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(50),
        ),
      ),
    );
  }

  Widget _inputDatePicker() {
    return Obx(
      () => Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          // color: Colors.redAccent,
          border: Border.all(
            width: 1,
            color: AppColor.secondaryColor,
          ),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.con.dobController.value,
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
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1975),
                    lastDate: DateTime.now(),
                  ).then(
                    (value) => setState(() {
                      widget.con.dobController.value =
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
    );
  }

  Widget _buttonRegist() {
    return GestureDetector(
      onTap: () {
        widget.con.regist();
      },
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: const LinearGradient(
            colors: [AppColor.coreColor, Colors.white],
            stops: [0.8, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: Text(
            "Regist",
            style: GoogleFonts.robotoSlab(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
