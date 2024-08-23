import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_storage/firebase_storage.dart';


// fire-base constants

FirebaseAuthWeb auth = FirebaseAuthWeb.instance ;
FirebaseFirestore fireStore = FirebaseFirestore.instance;
FirebaseStorage firebaseStorage = FirebaseStorage.instance;
String user = auth.currentUser!.uid;
// User? get currentUser => FirebaseAuth.instance.currentUser;


const userCollection = 'users';





