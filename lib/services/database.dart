import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:no_name/models/user.dart';

const String STHWENTWRONG = "Something went wrong, please try again";

class DatabaseServices {
  final String? uid;

  DatabaseServices({this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection("User");

  Future setUserData(UserModel userModel) async {
    try {
      return await _userCollection.doc(uid).set({
        "name": userModel.name,
        "email": userModel.email,
        "username": userModel.username,
      });
    } catch (e) {
      print("setUserData: ${e.toString()}");
      Future.error("Something went wrong, please try again\n"
          "Couldn't set user data");
    }
  }
}
