import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../consts/firebase_constants.dart';
import '../reusables/toast_class.dart';
import '../views/dashboard_screens/dasboard_screen.dart';
import 'dart:html' as html;
import 'package:firebase_auth_web/firebase_auth_web.dart';

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
        auth.signInWithEmailAndPassword(email.text.trim(), password.text.trim()).then((value) {
         isLoading(false);
         ToastClass.showToastClass(context: context, message: 'Login successfully');
         Get.offAll(() => DashBoardScreen(currentUserId: value.user!.uid), transition: Transition.cupertino);
       });
    }catch(e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

   signup({required BuildContext context}) async {

    try {
      isLoading(true);
      await  auth.createUserWithEmailAndPassword(email.text.trim(), password.text.trim()).then((value){
        print('Userid : ${value.user!.uid}');
        storeUserData(value.user!.uid,referrerId,referrerName);
        isLoading(false);
        Get.offAll(() => DashBoardScreen(currentUserId: value.user!.uid,));
        ToastClass.showToastClass(context: context, message: 'Account Created successfully');
      });

    }catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

 forgotPassword(
      {required BuildContext context}) async {
    try {
      isLoading(true);
      auth.sendPasswordResetEmail(email.text.trim(),);
    } catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

  Future logout({required BuildContext context}) async {
    try {
      isLoading(true);
      await auth.signOut();
      isLoading = false.obs;
    }catch (e) {
      isLoading(false);
      ToastClass.showToastClass(context: context, message: e.toString());
    }
  }

  // store user data
  Future<void> storeUserData(String userId, String? referrerId, String? referrerName) async {
    DocumentReference userDocRef = fireStore.collection(userCollection).doc(userId);

    // Store the new user's data
    await userDocRef.set({
      'name': name.text.trim(),
      'email': email.text.trim(),
      'phone': phoneNumber.text.trim(),
      'password': password.text.trim(),
      'id': userId,
      'wallet': '2000',
      'referredByName': referrerName ?? 'none',
      'referredBy': referrerId ?? 'none',
      'referrals': [],
      'referralCount': 0,
      'referralBonus': 0,
    });
    // If referrer exists, add 20 bonus to their account
    if (referrerId != null && referrerId.isNotEmpty) {
      DocumentReference referrerDocRef = fireStore.collection(userCollection).doc(referrerId);
      await fireStore.runTransaction((transaction) async {
        DocumentSnapshot referrerDoc = await transaction.get(referrerDocRef);
        if (referrerDoc.exists) {
          List<dynamic> referrals = referrerDoc.get('referrals') ?? [];
          if (!referrals.contains(userId)) {
            referrals.add(userId);
            transaction.update(referrerDocRef, {
              'referrals': referrals,
              'referralCount': referrals.length,
              'referralBonus': FieldValue.increment(20),
              'wallet': FieldValue.increment(20), // Add 20 to the wallet
            });
          }
        }
      });
    }
  }
}
