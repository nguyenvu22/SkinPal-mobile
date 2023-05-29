import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skinpal/core/const/colors.dart';
import 'package:skinpal/helpers/dialog_helper.dart';
import 'package:skinpal/pages/login/login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginController con = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: w * 0.1),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.08,
            ),
            _loginLogo(w, h),
            SizedBox(
              height: h * 0.06,
            ),
            _inputEmail(),
            SizedBox(
              height: h * 0.01,
            ),
            _inputPassword(),
            SizedBox(
              height: h * 0.03,
            ),
            _buttonLogin(w, h),
            SizedBox(
              height: h * 0.03,
            ),
            _divider(w, h),
            SizedBox(
              height: h * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonGoogle(w, h),
                _buttonFacebook(w, h),
              ],
            ),
            Expanded(
              child: _buttonRegister(),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _loginLogo(w, h) {
    return Container(
      width: w * 0.9,
      height: h * 0.3,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 5,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: w * 0.35,
            child: ClipOval(
              child: Image.asset(
                'assets/images/avatar_login.png',
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 25,
                vertical: 35,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: GoogleFonts.robotoSlab(
                      color: AppColor.coreColor,
                      fontSize: w * 0.11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "Let's prepare for your beauty",
                    style: GoogleFonts.robotoSlab(
                      color: const Color(0xFF757575),
                      fontSize: w * 0.035,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputEmail() {
    return TextField(
      controller: con.emailController,
      keyboardType: TextInputType.emailAddress,
      maxLength: 50,
      decoration: InputDecoration(
        hintText: "What is your email?",
        hintStyle: GoogleFonts.robotoSlab(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        labelText: "Email",
        labelStyle: GoogleFonts.robotoSlab(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.all(20),
        suffixIcon: IconButton(
          onPressed: () {
            con.emailController.clear();
          },
          icon: const FaIcon(FontAwesomeIcons.xmark),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        icon: const FaIcon(FontAwesomeIcons.envelope, size: 30),
      ),
    );
  }

  Widget _inputPassword() {
    return TextField(
      controller: con.passwordController,
      keyboardType: TextInputType.text,
      obscureText: true,
      maxLength: 50,
      decoration: InputDecoration(
        hintText: "****",
        hintStyle: GoogleFonts.robotoSlab(
          fontSize: 17,
          fontWeight: FontWeight.w400,
        ),
        labelText: "Password",
        labelStyle: GoogleFonts.robotoSlab(
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        contentPadding: const EdgeInsets.all(20),
        suffixIcon: IconButton(
          onPressed: () {
            con.passwordController.clear();
          },
          icon: const FaIcon(FontAwesomeIcons.xmark),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        icon: const FaIcon(FontAwesomeIcons.key, size: 30),
      ),
    );
  }

  Widget _buttonLogin(w, h) {
    return GestureDetector(
      onTap: () => con.login(),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 10),
        margin: EdgeInsets.symmetric(horizontal: w * 0.15),
        decoration: BoxDecoration(
          color: Colors.green,
          gradient: const LinearGradient(
            colors: [AppColor.coreColor, Colors.white],
            stops: [0.75, 1.0],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Text(
          "Login",
          style: GoogleFonts.acme(
            color: Colors.white,
            fontSize: w * 0.05,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _divider(w, h) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: w * 0.25,
          height: 1,
          color: const Color(0xFFBDBDBD),
        ),
        Text(
          "or log in with",
          style: GoogleFonts.robotoSlab(),
        ),
        Container(
          width: w * 0.25,
          height: 1,
          color: const Color(0xFFBDBDBD),
        )
      ],
    );
  }

  Widget _buttonGoogle(w, h) {
    return GestureDetector(
      onTap: () {
        // GoogleSignIn().signIn();
        con.loginWithGoogleAccount();
      },
      child: Container(
        width: w * 0.35,
        decoration: BoxDecoration(
          color: const Color(0xFFD8D8D8).withOpacity(0.5),
          borderRadius: BorderRadius.circular(50),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Row(
          children: [
            Image.asset("assets/images/google_image.png"),
            Expanded(
              child: Text(
                "Google",
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoSlab(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonFacebook(w, h) {
    return GestureDetector(
      onTap: () {
        // GoogleSignIn().signOut();
        DialogHelper.showLoading();
      },
      child: Container(
        width: w * 0.35,
        decoration: BoxDecoration(
          color: const Color(0xFF3C5A9A),
          borderRadius: BorderRadius.circular(50),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 25,
          vertical: 20,
        ),
        child: Row(
          children: [
            Image.asset("assets/images/facebook_image.png"),
            Expanded(
              child: Text(
                "Facebook",
                textAlign: TextAlign.center,
                style: GoogleFonts.robotoSlab(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttonRegister() {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.only(
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't you have an account?",
            style: GoogleFonts.robotoSlab(
              fontSize: 15,
            ),
          ),
          GestureDetector(
            onTap: () => con.goToRegisterPage(),
            child: Text(
              "  Regist now.",
              style: GoogleFonts.robotoSlab(
                color: const Color.fromARGB(255, 241, 119, 58),
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
