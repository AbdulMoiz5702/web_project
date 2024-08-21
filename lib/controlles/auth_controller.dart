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

  Future<UserCredential?> login({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      isLoading(true);
      userCredential = await auth.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (userCredential != null) {
        isLoading(false);
        ToastClass.showToastClass(context: context, message: 'Login successfully');
        Get.offAll(() => Dashboardscreen(currentUserid: userCredential!.user!.uid), transition: Transition.cupertino);
      }
    } on FirebaseAuthException catch (e) {
      logout(context: context);
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
    return userCredential;
  }

  Future<UserCredential?> signup({required BuildContext context}) async {
    UserCredential? userCredential;
    try {
      isLoading(true);
      userCredential = await auth.createUserWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );
      if (userCredential != null) {
        storeUserData();
        isLoading(false);
        ToastClass.showToastClass(context: context, message: 'Account Created successfully');
        Get.offAll(() => Dashboardscreen(currentUserid: userCredential!.user!.uid));
      }
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
    return userCredential;
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
  storeUserData() async {
    DocumentReference store =
        fireStore.collection(userCollection).doc(currentUser!.uid);
    await store.set({
      'name': name.text.trim(),
      'password': password.text.trim(),
      'phone': email.text.trim(),
      'reference':
          referenceCode.text.isEmpty ? 'none' : referenceCode.text.trim(),
      'id': currentUser!.uid,
    });
  }
}
