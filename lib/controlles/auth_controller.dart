import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../consts/firebase_constants.dart';
import '../reusables/toast_class.dart';
import '../views/dashboard_screens/dasboard_screen.dart';

class AuthController extends GetxController {
  var isLoading = false.obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phoneNumber = TextEditingController();
  var referenceCode = TextEditingController();

   login({required BuildContext context}) async {
    try {
      isLoading(true);
       await auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      ).then((value) {
         isLoading(false);
         ToastClass.showToastClass(context: context, message: 'Login successfully');
         Get.offAll(() => DashBoardScreen(currentUserId: value.user!.uid), transition: Transition.cupertino);
       });
    }  catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

   signup({required BuildContext context}) async {

    try {
      isLoading(true);
      await auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      ).then((value){
        print('Userid : ${value.user!.uid}');
        storeUserData(value.user!.uid);
        isLoading(false);
        Get.offAll(() => DashBoardScreen(currentUserId: value.user!.uid,));
        ToastClass.showToastClass(context: context, message: 'Account Created successfully');
      });

    } on FirebaseAuthException catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

  Future<UserCredential?> forgotPassword(
      {required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      isLoading(true);
      auth.sendPasswordResetEmail(
        email: email.text.trim(),
      );
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
    return userCredential;
  }

  Future logout({required BuildContext context}) async {
    try {
      isLoading(true);
      await auth.signOut();
      isLoading = false.obs;
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

  // store user data
  storeUserData(userId) async {
    DocumentReference store = fireStore.collection(userCollection).doc(userId);
    await store.set({
      'name': name.text.trim(),
      'email':email.text.trim(),
      'phone': phoneNumber.text.trim(),
      'password': password.text.trim(),
      'reference': referenceCode.text.isEmpty ? 'none' : referenceCode.text.trim(),
      'id': userId,
      'wallet': '2000',
    });
  }
}
