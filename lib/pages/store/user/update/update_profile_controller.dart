import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skinpal/helpers/dialog_helper.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';
import 'package:skinpal/pages/store/user/profile/profile_controller.dart';
import 'package:skinpal/providers/users_provider.dart';

class UpdateProfileController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  // late var dobController = "${userSession.dob?.substring(0, 10)}".obs;
  late String dobController = "${userSession.dob?.substring(0, 10)}";

  ImagePicker picker = ImagePicker();
  File? imageFile;

  User userSession = User.fromJson(GetStorage().read('user') ?? {});
  UsersProvider usersProvider = UsersProvider();
  ProfileController profileController = Get.find(); //update another controller

  UpdateProfileController() {
    nameController.text = userSession.name!;
  }

  void modify() async {
    String name = nameController.text;
    String password = passwordController.text.trim();
    String cfmPassword = confirmPasswordController.text.trim();

    if (isValid(name, password, cfmPassword)) {
      User user = User(
        id: userSession.id,
        name: name,
        email: userSession.email,
        password: password.isEmpty ? userSession.password : password,
        dob: dobController,
      );

      if (imageFile == null) {
        DialogHelper.showLoading('Updating...');
        ResponseApi responseApi = await usersProvider.update(user);
        DialogHelper.hideLoading();
        if (responseApi.success == true) {
          Get.snackbar(
            "Process complete!",
            responseApi.message ?? '',
            borderWidth: 1,
            borderColor: Colors.greenAccent,
            icon: const Icon(
              Icons.error,
              color: Colors.greenAccent,
            ),
          );

          GetStorage().write('user', responseApi.data);

          profileController.userSession.value = User.fromJson(responseApi.data);
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
      } else {
        // DialogHelper.showLoading('Updating...');
        Stream stream = await usersProvider.updateWithImg(user, imageFile!);
        stream.listen((res) {
          ResponseApi responseApi = ResponseApi.fromJson(json.decode(res));
          // DialogHelper.hideLoading();
          if (responseApi.success == true) {
            Get.snackbar(
              "Process complete!",
              responseApi.message ?? '',
              borderWidth: 1,
              borderColor: Colors.greenAccent,
              icon: const Icon(
                Icons.error,
                color: Colors.greenAccent,
              ),
            );
            //update to useSession
            GetStorage().write('user', responseApi.data);

            profileController.userSession.value =
                User.fromJson(responseApi.data);
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
        });
      }
    }
  }

  bool isValid(String name, String password, String cfmPassword) {
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
    if (password == userSession.password) {
      Get.snackbar(
        "Your password is matching the current password!",
        "Try some new password",
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
    return true;
  }

  Future selectImage(ImageSource imageSource) async {
    XFile? image = await picker.pickImage(source: imageSource);
    if (image != null) {
      imageFile = File(image.path);
      update();
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget galleryButton = ElevatedButton(
      onPressed: () {
        Get.back();
        selectImage(ImageSource.gallery);
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
        Get.back();
        selectImage(ImageSource.camera);
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
