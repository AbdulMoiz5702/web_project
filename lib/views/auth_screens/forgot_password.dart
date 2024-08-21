import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:website_project/consts/colors.dart';
import 'package:website_project/controlles/auth_controller.dart';
import 'package:website_project/reusables/custom_button.dart';
import 'package:website_project/reusables/custom_indicator.dart';
import 'package:website_project/reusables/custom_sizedBox.dart';
import 'package:website_project/reusables/custom_textfeild.dart';
import 'package:website_project/reusables/text_widgets.dart';
import 'package:website_project/views/auth_screens/login_screen.dart';



class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

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
            smallText(title: 'Please provide a valid email address to because we will send you a conformation email to reset your password',height: 1.5,color: blueColor),
            Sized(height: 0.04,),
            CustomTextField(controller: controller.email, hintText: 'Email', validate: (v){},iconData: Icons.mail,),
            Sized(height: 0.04,),
            Obx(()=> controller.isLoading.value == true ?  CustomIndicator() : CustomButton(title: 'Confirm', onTap: (){
              controller.signup(context: context);
            })),
            Sized(height: 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                smallText(title: 'Go back to?',color: blueColor),
                Sized(width: 0.02,height: 0,),
                GestureDetector(
                    onTap: (){
                      Get.to(()=> LoginScreen());
                    },
                    child: mediumText(title: 'Login',fontSize: 14)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
