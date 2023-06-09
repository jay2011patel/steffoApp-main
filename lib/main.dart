import 'dart:async';

import 'package:email_auth/email_auth.dart';
import 'package:email_otp/email_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stefomobileapp/pages/ChangePP.dart';
import 'package:stefomobileapp/pages/DistBuyerspage.dart';
import 'package:stefomobileapp/pages/EditableProfilePage.dart';
import 'package:stefomobileapp/pages/ForgetPassPage.dart';
import 'package:stefomobileapp/pages/HomePage.dart';
import 'package:stefomobileapp/pages/InventoryPage.dart';
import 'package:stefomobileapp/pages/LoginPage.dart';
import 'package:stefomobileapp/pages/OTPPage.dart';
import 'package:stefomobileapp/pages/OrdersPage.dart';
import 'package:stefomobileapp/pages/ProfilePage.dart';
import 'package:stefomobileapp/pages/RegistrationPage.dart';
import 'package:stefomobileapp/pages/RequestPage.dart';
import 'package:stefomobileapp/pages/PlaceOrderPage.dart';
import 'package:stefomobileapp/pages/UserProfilePage.dart';
import 'package:stefomobileapp/pages/addItem.dart';
import 'package:stefomobileapp/pages/newPassPage.dart';
import 'pages/LRPage.dart';
import 'UI/common.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      theme: ThemeData(
          textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme)),
      title: 'Flutter Demo',
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      routes: <String, WidgetBuilder>{
        '/lrpage': (BuildContext context) => LRPage(),
        '/login': (BuildContext context) => LoginPage(),
        '/register': (BuildContext context) => RegistrationPage(),
        '/home': (BuildContext context) => HomePage(),
        '/inventory': (BuildContext context) => InventoryPage(),
        '/dealer': (BuildContext context) => DealerPage(),
        '/orderreq': (BuildContext context) => RequestPage(),
        //'/challanlist': (BuildContext context) => ChallanListPage(),
        '/placeorder': (BuildContext context) => PlaceOrderPage(),
        '/orders': (BuildContext context) => OrdersPage(),
        //'/gnchallan': (BuildContext context) => GenerateChallanPage(),
        //'/order': (BuildContext context) => OrderDetails(),
        // '/challan': (BuildContext context) => GeneratedChallan(),
        '/profile': (BuildContext context) => UserProfilePage(),
        '/editprofile': (BuildContext context) => EditableProfilePage(),
        '/forgetPass': (BuildContext context) => ForgetPassPage(),
        '/OTP': (BuildContext context) => OTPPage(),
        '/newPass': (BuildContext context) => NewPassPage(),
        '/profilePage': (BuildContext context) => ProfilePage(),

        //'/request': (BuildContext context) => UserRequestPage(),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  bool allowDirectLogin = false;
  loadData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('isLoggedIn')) {
      allowDirectLogin = true;
    }
  }

  @override
  void initState() {
    loadData();
    Timer(Duration(seconds: 4), () {
      if (allowDirectLogin) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        Navigator.of(context).pushReplacementNamed('/lrpage');
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            logo(context).animate().fade(duration: Duration(seconds: 1)),
            //Form()
          ],
        ),
      ),
    );
  }
}
