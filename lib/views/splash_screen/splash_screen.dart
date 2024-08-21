import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_project/controlles/splash_controller.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  var controller = Get.put(SplashController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.onInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
    );
  }
}
