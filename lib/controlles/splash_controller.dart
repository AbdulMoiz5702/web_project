



import 'package:get/get.dart';
import 'package:website_project/consts/firebase_constants.dart';
import 'package:website_project/views/auth_screens/login_screen.dart';

import '../views/dashboard_screens/dasboard_screen.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUserStatus();
  }

  checkUserStatus() {
    Future.delayed(Duration.zero, () {
      final userId = auth.currentUser?.uid;
      if (userId != null) {
        Get.offAll(() => DashBoardScreen(currentUserId: userId));
      } else {
        print('No user found, navigating to login screen');
        Get.offAll(() => LoginScreen());
      }
    });
  }

}



