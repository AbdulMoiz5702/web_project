import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../consts/firebase_constants.dart';
import '../reusables/toast_class.dart';
import '../views/dashboard_screens/dasboard_screen.dart';
import 'dart:html' as html;

class AuthController extends GetxController {
  var isLoading = false.obs;
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var phoneNumber = TextEditingController();
  var referenceCode = TextEditingController();
  String? referrerId;
  String? referrerName;


  @override
  void onInit() {
    super.onInit();
    initReferralLink();
  }

  Future<void> initReferralLink() async {
    try {
      // Get the current URL
      final uri = Uri.parse(html.window.location.href);
      print('URL: $uri');
       referrerId = uri.queryParameters['referrerId'];
       referrerName = uri.queryParameters['username'];
      if (referrerId != null) {
        print('Referrer ID: $referrerId');
      }
      if (referrerName != null) {
        print('Username: $referrerName');
      }

    } catch (e) {
      print('Error initializing referral link: $e');
    }
  }

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
        storeUserData(value.user!.uid,referrerId,referrerName);
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
  Future<void> storeUserData(String userId, String? referrerId,String? referrerName) async {
    DocumentReference store = fireStore.collection(userCollection).doc(userId);

    await store.set({
      'name': name.text.trim(),  // Add other user details here as needed
      'email': email.text.trim(),
      'phone': phoneNumber.text.trim(),  // Add other user details here as needed
      'password': password.text.trim(),
      'id': userId,
      'wallet': '2000',
      'referredByName': referrerName ?? 'none',
      'referredBy': referrerId ?? 'none',
      'referrals': FieldValue.arrayUnion([]),
      'referralCount': 0,
    });

    if (referrerId != null && referrerId.isNotEmpty) {
      final referrerDocRef = fireStore.collection(userCollection).doc(referrerId);
      final referrerDoc = await referrerDocRef.get();
      if (referrerDoc.exists) {
        final referrals = List<String>.from(referrerDoc.data()?['referrals'] ?? []);
        if (!referrals.contains(userId)) {
          referrals.add(userId);
          await referrerDocRef.update({
            'referrals': referrals,
            'referralCount': referrals.length,
          });
        }
      }
    }
  }
}
