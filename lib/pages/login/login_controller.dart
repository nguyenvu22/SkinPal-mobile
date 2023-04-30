import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/providers/users_provider.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  var googleSignIn = GoogleSignIn();
  var googleAccount = Rx<GoogleSignInAccount?>(null);

  UsersProvider usersProvider = UsersProvider();

  void login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (isValid(email, password)) {
      // Get.snackbar(
      //   "oke",
      //   "Ngol",
      //   // colorText: Colors.greenAccent,
      //   borderWidth: 2,
      //   borderColor: Colors.greenAccent,
      //   icon: const Icon(
      //     Icons.check,
      //     color: Colors.greenAccent,
      //   ),
      // );

      ResponseApi responseApi = await usersProvider.login(email, password);

      if (responseApi.success == true) {
        GetStorage().write('user', responseApi.data);
        goToHomePage();
      } else {
        Get.snackbar(
          "An error has occurred!",
          responseApi.message ?? '',
          borderWidth: 1,
          borderColor: Colors.redAccent,
          icon: const Icon(
            Icons.error,
            color: Colors.redAccent,
          ),
        );
      }
    }
  }

  void goToHomePage() {
    Get.offNamedUntil("/store", (route) => false);
  }

  bool isValid(String email, String password) {
    if (email.isEmpty) {
      Get.snackbar(
        "An error has occurred!",
        "Please fill your email",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (!GetUtils.isEmail(email)) {
      Get.snackbar(
        "An error has occurred!",
        "Invalid email format",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (password.isEmpty) {
      Get.snackbar(
        "An error has occurred!",
        "Please fill your password",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    return true;
  }

  void loginWithGoogleAccount() async {
    googleAccount.value = await googleSignIn.signIn();

    if (googleAccount.value == null) {
      Get.snackbar("Loggin by Google fail", "Something went wrong!!");
    } else {
      // GoogleSignInAccount:{
      //  displayName: Nguyen Trong Nguyen Vũ,
      //  email: vuntnse151234@fpt.edu.vn,
      //  id: 110182969004611450180,
      //  photoUrl: https://lh3.googleusercontent.com/a/AGNmyxbF0SIxWjRcyrw_2CrJpomlXIAYKqgcMbdRJs6N=s96-c, serverAuthCode: 4/0AVHEtk6cjXeUGc-cZO7goNd1tcN7sMR8Hj-BTuc7E3xO1K0l9qmHK6E10m5rsCCfg3bqUA
      // }
      print('GoogleAccount: ${googleAccount}');
    }
  }

  void goToRegisterPage() {
    Get.toNamed("/regist");
  }
}
