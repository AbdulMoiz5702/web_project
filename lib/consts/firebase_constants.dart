import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';


// fire-base constants

FirebaseAuth auth = FirebaseAuth.instance ;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
User ? currentUser = auth.currentUser ;
String user = auth.currentUser!.uid;


const userCollection = 'users';





