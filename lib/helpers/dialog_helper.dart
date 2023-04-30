import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DialogHelper {
  //show loading
  static void showLoading([String? message]) {
    Get.dialog(
      Dialog(
        backgroundColor: Colors.black45,
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(
                strokeWidth: 5,
              ),
              const SizedBox(
                width: 20,
              ),
              Flexible(
                child: Text(
                  message ?? 'Loading...',
                  style: GoogleFonts.roboto(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //hide loading
  static void hideLoading() {
    if (Get.isDialogOpen!) Get.back();
  }
}
