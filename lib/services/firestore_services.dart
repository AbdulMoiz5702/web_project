import '../consts/firebase_constants.dart';

class FireStoreServices{


  static getUserInformation(userId){
    return fireStore.collection(userCollection).doc(userId).snapshots();
  }

}