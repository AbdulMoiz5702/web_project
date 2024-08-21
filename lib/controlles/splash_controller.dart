



import 'package:get/get.dart';
import 'package:website_project/consts/firebase_constants.dart';
import 'package:website_project/views/auth_screens/login_screen.dart';
import 'package:website_project/views/main_screen/main_screen.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    checkUserStatus();
  }

  checkUserStatus(){
    Future.delayed(Duration.zero,(){
      if(currentUser?.uid != null){
        Get.to(()=> MainScreen());
        print('main screen');
      }else{
        Get.to(()=> LoginScreen());
        print('login screen');
      }
    });
  }


}