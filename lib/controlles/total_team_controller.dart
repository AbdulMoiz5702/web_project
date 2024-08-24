import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:website_project/consts/firebase_constants.dart';

class TotalTeamController extends GetxController {
  Stream<List<Map<String, dynamic>>> getReferredUsersStream(List<String> userIds) {
    // Check if the list is empty and return an empty stream if true
    if (userIds.isEmpty) {
      return Stream.value([]); // Return an empty list stream
    }

    return FirebaseFirestore.instance
        .collection(userCollection) // Replace with your collection name
        .where(FieldPath.documentId, whereIn: userIds)
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }
}
