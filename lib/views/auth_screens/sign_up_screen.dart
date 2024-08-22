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



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var controller = Get.put(AuthController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.onInit();

  }
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
            CustomTextField(controller: controller.name, hintText: 'Name', validate: (v){},iconData: Icons.person,),
            Sized(height: 0.02,),
            CustomTextField(controller: controller.email, hintText: 'Email', validate: (v){},iconData: Icons.mail,),
            Sized(height: 0.02,),
            CustomTextField(controller: controller.phoneNumber, hintText: 'Phone', validate: (v){},iconData: Icons.phone,keyboardType: TextInputType.number,),
            Sized(height: 0.02,),
            CustomTextField(controller: controller.referenceCode, hintText: 'Reference Code ( optional )', validate: (v){},iconData: Icons.cable_outlined,),
            Sized(height: 0.02,),
            CustomTextField(controller: controller.password, hintText: 'Password', validate: (v){},iconData: Icons.lock,),
            Sized(height: 0.04,),
            Obx(()=> controller.isLoading.value == true ?  CustomIndicator() : CustomButton(title: 'Signup', onTap: (){
              controller.signup(context: context);
            })),
            Sized(height: 0.02,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                smallText(title: 'Already have an account?',color: blueColor),
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
