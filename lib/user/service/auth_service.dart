import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;


  User? getCurrentUser(){
    User? user = _auth.currentUser;
    return user;
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getCurrentUserInfo() async{
    return await FirebaseFirestore.instance.collection("users").doc(getCurrentUser()!.uid).get();
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      // sign in user using firebase authentication with email and password

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // fetching the user's role from firestore to determine access level
      DocumentSnapshot userDoc =
          await _firestore
              .collection("users")
              .doc(userCredential.user!.uid)
              .get();
      return null; //return the role of the user
    } catch (e) {
      return e.toString();
    }
  }

  Future<String?> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // create user in firebase authentication with email and password

      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(
        email: email.trim(), password: password.trim(),);

      // save additional user data in firestore (name, rile, email)
      await _firestore.collection("users").doc(
          userCredential.user!.uid).set({
        'name': name.trim(),
        "email": email.trim(),
      });
      return null; // success no error message

    } catch (e) {
      return e.toString();
    }
  }

  //for user logout
  signOut() async{
    _auth.signOut();
  }

}
