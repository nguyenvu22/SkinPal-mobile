import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinpal/helpers/dialog_helper.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';
import 'package:skinpal/providers/users_provider.dart';

class RegistController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  var dobController = "2000-01-01".obs;
  TextEditingController avatarController = TextEditingController();

  ImagePicker picker = ImagePicker();
  File? imageFile;

  UsersProvider usersProvider = UsersProvider();

  void regist() async {
    String email = emailController.text;
    String name = nameController.text;
    String password = passwordController.text.trim();
    String cfmPassword = confirmPasswordController.text.trim();

    if (isValid(email, name, password, cfmPassword)) {
      User user = User(
        email: email,
        name: name,
        password: password,
        dob: dobController.value,
      );

      // ResponseApi responseApi;
      if (imageFile == null) {
        ResponseApi responseApi = await usersProvider.regist(user);
        //Custom response
        if (responseApi.success != true) {
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
        } else {
          DialogHelper.showLoading('Registration processing...');
          Future.delayed(
            const Duration(seconds: 2),
            () {
              DialogHelper.hideLoading();
              // Get.back();
              Navigator.of(Get.overlayContext!).maybePop();
              Get.snackbar(
                "Regist a new account successfully",
                "You now have an account",
                borderWidth: 1,
                borderColor: Colors.greenAccent,
                icon: const Icon(
                  Icons.check,
                  color: Colors.greenAccent,
                ),
              );
            },
          );
        }
      } else {
        // simple size file
        // ResponseApi responseApi = await usersProvider.registWithImg(user, imageFile!);

        // heavy size file
        Stream stream = await usersProvider.registWithImgPlus(user, imageFile!);
        stream.listen((res) {
          //convert json string to dynamic object by json.decode
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));

          //Custom response
          if (responseApi.success != true) {
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
          } else {
            DialogHelper.showLoading('Registration processing...');
            Future.delayed(
              const Duration(seconds: 2),
              () {
                DialogHelper.hideLoading();
                // Get.back();
                Navigator.of(Get.overlayContext!).maybePop();
                Get.snackbar(
                  "Regist a new account successfully",
                  "You now have an account",
                  borderWidth: 1,
                  borderColor: Colors.greenAccent,
                  icon: const Icon(
                    Icons.check,
                    color: Colors.greenAccent,
                  ),
                );
              },
            );
          }
        });
      }
    }
  }

  bool isValid(String email, String name, String password, String cfmPassword) {
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
    if (name.isEmpty) {
      Get.snackbar(
        "An error has occurred!",
        "Please fill your name",
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
    if (cfmPassword.isEmpty) {
      Get.snackbar(
        "An error has occurred!",
        "Please fill your confirm password",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (cfmPassword != password) {
      Get.snackbar(
        "An error has occurred!",
        "Confirm Password does not match Password",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (imageFile == null) {
      Get.snackbar(
        "An error has occurred!",
        "Select your avatar",
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

  //Allow to choose img in GALLERY or CAMERA
  //ImageSource from img-picker
  Future selectImage(ImageSource imageSource) async {
    //XFile from img-picker:
    //- use XFile to get an image file selected by the user
    //- pickImage() returns an XFile object representing the selected file.
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      //If user choose a img -> create a file with the img's path
      imageFile = File(image.path);

      //Instant load for img after set => No need to ctrl+save
      update();
    }
  }

  // 2 ways to use Camera or access to the gallery
  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        //navigate back to the previous screen or route.
        Get.back();
        selectImage(ImageSource.gallery); //Access the gallery in android
      },
      child: Text(
        "GALLERY",
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
    Widget cameraButton = ElevatedButton(
      onPressed: () {
        //navigate back to the previous screen or route.
        Get.back();
        selectImage(ImageSource.camera); //Access the camera in android
      },
      child: Text(
        "CAMERA",
        style: GoogleFonts.roboto(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    AlertDialog alertDialog = AlertDialog(
      title: Center(
        child: Text(
          "Select an option: ",
          style: GoogleFonts.roboto(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [galleryButton, cameraButton],
      actionsPadding: const EdgeInsets.all(30),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alertDialog;
      },
    );
  }
}
