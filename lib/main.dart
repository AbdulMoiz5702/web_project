import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_project/views/auth_screens/login_screen.dart';
import 'package:website_project/views/auth_screens/sign_up_screen.dart';
import 'package:website_project/views/dashboard_screens/dasboard_screen.dart';
import 'package:website_project/views/splash_screen/splash_screen.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: "AIzaSyBStAOPRM6cuSIBB3KRhtpKycZ9nQOPr5w",
        authDomain: "website-4fa8c.firebaseapp.com",
        projectId: "website-4fa8c",
        storageBucket: "website-4fa8c.appspot.com",
        messagingSenderId: "191031982536",
        appId: "1:191031982536:web:4c8dd470895caa075468fd",
        measurementId: "G-MWSZG5D6GC"
    ),
  );
  // EasypaisaFlutter.initialize(
  //     'rideoptions',
  //     'd7d530ae300bf32090a2a0bc932ac708',
  //     '25056',
  //     true /*is testing account or not*/,
  //     AccountType.MA /*Merchant account type either Mobile account or OTC */);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
      getPages: [
        // GetPage(name: '/', page: () => SplashScreen()), // Your initial screen
        GetPage(name: '/', page: () => DashBoardScreen()), // Your main screen
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/signup', page: () => SignupScreen()),
      ],
    );
  }
}

