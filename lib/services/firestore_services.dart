import 'package:flutter/material.dart';

import '../consts/firebase_constants.dart';

class FirestoreServices{
  static getUserInformation(userid){
    return fireStore.collection(userCollection).doc(userid).snapshots();
  }

}