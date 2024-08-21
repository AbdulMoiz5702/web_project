import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_project/consts/colors.dart';
import 'package:website_project/controlles/auth_controller.dart';
import 'package:website_project/reusables/custom_button.dart';
import 'package:website_project/reusables/custom_indicator.dart';
import 'package:website_project/reusables/custom_sizedBox.dart';
import 'package:website_project/reusables/custom_textfeild.dart';
import 'package:website_project/reusables/text_widgets.dart';
import 'package:website_project/views/auth_screens/sign_up_screen.dart';

import 'forgot_password.dart';



class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextField(controller: controller.email, hintText: 'Email', validate: (v){},iconData: Icons.mail,),
            Sized(height: 0.02,),
            CustomTextField(controller: controller.password, hintText: 'Password', validate: (v){},iconData: Icons.lock,),
            Sized(height: 0.02,),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: (){
                    Get.to(()=> ForgotPassword());
                  },
                  child: smallText(title: 'Forgot Password?',color:blueColor)),
            ),
            Sized(height: 0.04,),
            Obx(()=> controller.isLoading.value == true ?  CustomIndicator() : CustomButton(title: 'Login', onTap: (){
              controller.login(context: context);
            })),
            Sized(height: 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                smallText(title: 'Create an account?',color: blueColor),
                Sized(width: 0.02,height: 0,),
                GestureDetector(
                    onTap: (){
                      Get.to(()=> SignupScreen());
                    },
                    child: mediumText(title: 'Signup',fontSize: 14)),
              ],
            )


          ],
        ),
      ),
    );
  }
}
