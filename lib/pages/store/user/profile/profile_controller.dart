import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:skinpal/pages/store/store_controller.dart';
import 'package:skinpal/providers/users_provider.dart';

class ProfileController extends GetxController {
  var userSession = User.fromJson(GetStorage().read('user') ?? {}).obs;

  Map<String, dynamic>? paymentIntentData;

  UsersProvider usersProvider = UsersProvider();

  StoreController storeController = Get.find();

  Future<void> makePayment(context) async {
    try {
      paymentIntentData = await createPaymentIntent(5, 'USD');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              applePay: true,
              googlePay: true,
              // testEnv: true,
              style: ThemeMode.dark,
              merchantCountryCode: 'US',
              merchantDisplayName: 'NguynVuu',
            ),
          )
          .then((value) {});

      showPaymentSheet(context).then((_) {
        paymentSuccess().then((_) {
          // userSession.value.isPremium = true;
          //Change a single attribute in Object -> Using update
          userSession.update((user) {
            user!.isPremium = true;
          });

          GetStorage().write('user', userSession.value);
          // storeController.user = userSession.value;

          Navigator.pop(context);
        });
      });
    } catch (err) {
      print("Error: $err");
    }
  }

  paymentSuccess() async {
    DateTime now = DateTime.now();
    ResponseApi responseApi = await usersProvider.updatePremium(
        now.toString(), now.add(const Duration(days: 30)).toString());
    if (responseApi.success == false) {
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
      return;
    } else {
      Get.snackbar(
        "Congratulation",
        responseApi.message ?? '',
        borderWidth: 1,
        borderColor: Colors.greenAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.greenAccent,
        ),
      );
      return;
    }
  }

  showPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        print("Error at transaction part : $error - $stackTrace");
      });
    } on StripeException catch (err) {
      print("Error: $err");
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          content: Text("Cancel"),
        ),
      );
    } catch (err) {
      print("Error: $err");
    }
  }

  createPaymentIntent(int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': (amount * 100).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51Mk9FtKueH0OP89Ts8CKqsJZUF2qTvpvEcAEDMQ0CH8SPfMx5qhKi0D4U1rGjvg1Bao3cTNoavoTfHaiq2lPJ49B00ungKZ8sf',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print("Error: $err");
    }
  }
}
