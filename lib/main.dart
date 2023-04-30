import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skinpal/models/user.dart';
import 'package:skinpal/pages/checkout/checkout_page.dart';
import 'package:skinpal/pages/login/login_page.dart';
import 'package:skinpal/pages/onboard/onboard/onboard_page.dart';
import 'package:skinpal/pages/onboard/splash/splash_page.dart';
import 'package:skinpal/pages/product/product_detail_page.dart';
import 'package:skinpal/pages/regist/regist_page.dart';
import 'package:skinpal/pages/store/store_page.dart';
import 'package:skinpal/pages/store/user/favorite/favorite_page.dart';
import 'package:skinpal/pages/store/user/routine/list/routine_list_page.dart';
import 'package:skinpal/pages/store/user/update/update_profile_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await GetStorage.init();

  final prefs = await SharedPreferences.getInstance();
  final isFirstMeet = prefs.getBool('isFirstMeet') ?? false;

  Stripe.publishableKey =
      'pk_test_51Mk9FtKueH0OP89TQ4nyNqYtbF0eXbUlsM9769qToD2DCG319sNf5rC5vV9huTdJ7C2hYgnaX2MR2nDJ1dStGCNA00bYtyMTsF';
  await Stripe.instance.applySettings();

  runApp(MyApp(isFirstMeet: isFirstMeet));
}

class MyApp extends StatefulWidget {
  final bool isFirstMeet;
  const MyApp({super.key, required this.isFirstMeet});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("userSession: ${userSession.toJson()}");
    return GetMaterialApp(
      title: "SkinPal App",
      debugShowCheckedModeBanner: false,
      initialRoute: widget.isFirstMeet
          ? userSession.id != null
              ? "/store"
              : "/login"
          : "/splash",
      getPages: [
        GetPage(name: "/splash", page: () => const SplashPage()),
        GetPage(name: "/onboard", page: () => OnboaradPage()),
        GetPage(name: "/login", page: () => LoginPage()),
        GetPage(name: "/regist", page: () => RegistPage()),
        GetPage(name: "/store", page: () => StorePage()),
        GetPage(name: "/profileCustomization", page: () => UpdateProfilePage()),
        GetPage(name: "/favorite", page: () => FavortitePage()),
        GetPage(name: "/productDetail", page: () => ProductDetailPage()),
        GetPage(name: "/checkout", page: () => CheckoutPage()),
        GetPage(name: "/routine", page: () => RoutineListPage()),
      ],
      theme: ThemeData(
        primaryColor: const Color(0xFFF4AA85),
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Color(0xFFF4AA85),
          onPrimary: Colors.black,
          secondary: Color.fromARGB(255, 244, 145, 96),
          onSecondary: Colors.black,
          error: Colors.grey,
          onError: Colors.grey,
          background: Colors.grey,
          onBackground: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.black,
        ),
      ),
      navigatorKey: Get.key,
    );
  }
}
