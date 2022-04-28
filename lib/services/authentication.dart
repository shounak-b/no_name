import 'package:firebase_auth/firebase_auth.dart';
import 'package:no_name/models/user.dart';
import 'package:no_name/services/database.dart';

class AuthenticationServices {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future signInWithMailPass(String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: mail, password: pass);

      return userCredential.user!.uid;
    } catch (e) {
      print("signInWithMailPass: ${e.toString()}");
      Future.error(STHWENTWRONG);
    }
  }

  Future registerWithMailPass(String name, String mail, String pass) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: mail, password: pass);
      User? user = userCredential.user;

      String uid = await DatabaseServices(uid: user!.uid).setUserData(UserModel(
        uid: user.uid,
        name: name,
        email: mail,
      ));

      return uid;
    } catch (e) {
      print("registerWithMailPass: ${e.toString()}");
      Future.error(STHWENTWRONG);
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print("signOut: ${e.toString()}");
      Future.error(STHWENTWRONG);
    }
  }
}
