import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skinpal/helpers/dialog_helper.dart';
import 'package:skinpal/models/order.dart';
import 'package:skinpal/models/product.dart';
import 'package:get_storage/get_storage.dart';
import 'package:skinpal/models/response_api.dart';
import 'package:skinpal/models/user.dart';
import 'package:skinpal/pages/store/cart/cart_controller.dart';
import 'package:http/http.dart' as http;
import 'package:skinpal/providers/orders_provider.dart';

class CheckoutController extends GetxController {
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  List<Product> productInCart = [];
  double totalPrice = 0.0;
  var isPayment = false.obs;
  var isComplete = false.obs;

  Map<String, dynamic>? paymentIntentData;

  User userSession = User.fromJson(GetStorage().read('user') ?? {});

  CartController cartController = Get.find();

  OrdersProvider ordersProvider = OrdersProvider();

  CheckoutController() {
    if (GetStorage().read("shoppingCart") != null) {
      if (GetStorage().read("shoppingCart") is List<Product>) {
        productInCart = GetStorage().read("shoppingCart");
      } else {
        productInCart = Product.fromJsonList(GetStorage().read("shoppingCart"));
      }
    }
    countTotal();
  }

  void test() async {
    Order takeOrder = Order(
      status: 0,
      totalPrice: totalPrice,
      address: addressController.text,
      phone: phoneController.text.trim(),
      idUser: userSession.id,
    );

    ResponseApi resOrder = await ordersProvider.createOrder(takeOrder);
  }

  void countTotal() {
    totalPrice = 0;
    for (var p in productInCart) {
      totalPrice += p.quantity! * p.price!;
    }
  }

  void paymentSuccess() async {
    DialogHelper.showLoading("Preparing your order...");

    Order takeOrder = Order(
      status: 0,
      totalPrice: totalPrice,
      address: addressController.text,
      phone: phoneController.text.trim(),
      idUser: userSession.id,
    );

    ResponseApi resOrder = await ordersProvider.createOrder(takeOrder);
    print("resOrder : ${resOrder.toJson()}");

    if (resOrder.success == true) {
      for (var product in productInCart) {
        ResponseApi resOrderDetail = await ordersProvider.createOrderDetail(
            resOrder.data, product.id!, product.quantity!);

        if (resOrderDetail.success == false) {
          Get.snackbar(
            "Something went wrong!",
            "Can not take your order",
            borderWidth: 1,
            borderColor: Colors.redAccent,
            icon: const Icon(
              Icons.error,
              color: Colors.redAccent,
            ),
          );
          isComplete.value = false;
          return;
        } else {
          isComplete.value = true;
        }
      }

      // clear storage
      GetStorage().remove("shoppingCart");
    } else {
      Get.snackbar(
        "Something went wrong!",
        "Can not take your order",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      isComplete.value = false;
      return;
    }
    DialogHelper.hideLoading();
  }

  void paymentProcess(context) {
    String phone = phoneController.text.trim();
    String address = addressController.text;
    if (!checkValid(phone, address)) {
      isComplete.value = false;
      return;
    }
    makePayment(context);
    // isComplete.value = true;
  }

  Future<bool> makePayment(context) async {
    try {
      paymentIntentData = await createPaymentIntent(totalPrice.toInt(), 'USD');
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

      showPaymentSheet(context);
      return true;
    } on StripeException catch (err) {
      if (err.error.localizedMessage == 'The payment flow has been canceled') {
        // Handle the case where the user canceled the payment process
        print('Payment was canceled by the user.');
      } else {
        // Handle other Stripe exceptions
        print('Stripe exception occurred: ${err.error.localizedMessage}');
      }
      return false;
    } catch (err) {
      print("Error: $err");
      return false;
    }
  }

  showPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    Expanded(
                      child: Text(
                        "Payment Successfully",
                        style: GoogleFonts.robotoSlab(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
        paymentIntentData = null;
        isPayment.value = true;

        //===================================================
        // Order takeOrder = Order(
        //   status: 0,
        //   totalPrice: totalPrice,
        //   address: addressController.text,
        //   phone: phoneController.text.trim(),
        //   idUser: userSession.id,
        // );

        // ResponseApi resOrder = await ordersProvider.createOrder(takeOrder);
        // print("resOrder : ${resOrder.toJson()}");

        // if (resOrder.success == true) {
        //   for (var product in productInCart) {
        //     ResponseApi resOrderDetail = await ordersProvider.createOrderDetail(
        //         resOrder.data, product.id!, product.quantity!);

        //     if (resOrderDetail.success == false) {
        //       Get.snackbar(
        //         "Something went wrong!",
        //         "Can not take your order",
        //         borderWidth: 1,
        //         borderColor: Colors.redAccent,
        //         icon: const Icon(
        //           Icons.error,
        //           color: Colors.redAccent,
        //         ),
        //       );
        //       isComplete.value = false;
        //       return;
        //     }
        //   }

        //   // clear storage
        //   GetStorage().remove("shoppingCart");
        // }
        // else {
        //   isComplete.value = false;
        //   Get.snackbar(
        //     "Something went wrong!",
        //     "Can not take your order",
        //     borderWidth: 1,
        //     borderColor: Colors.redAccent,
        //     icon: const Icon(
        //       Icons.error,
        //       color: Colors.redAccent,
        //     ),
        //   );
        //   return;
        // }
        //===================================================
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

  bool checkValid(String phone, String address) {
    if (phone.isEmpty) {
      Get.snackbar(
        "Missing information!",
        "Please fill your phone number for ordering",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (phone.length < 10) {
      Get.snackbar(
        "Missing information!",
        "Phone number is invalid",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (!phone.isPhoneNumber) {
      Get.snackbar(
        "Missing information!",
        "Phone number is invalid",
        borderWidth: 1,
        borderColor: Colors.redAccent,
        icon: const Icon(
          Icons.error,
          color: Colors.redAccent,
        ),
      );
      return false;
    }
    if (address.isEmpty) {
      Get.snackbar(
        "Missing information!",
        "Please fill your address for ordering",
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

  void goToHomePage() {
    Get.offNamedUntil("/store", (route) => false);
  }
}
