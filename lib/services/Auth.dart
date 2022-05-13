// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecom/models/userModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Auth {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future register(
      String email, String password, String name, String profile) async {
    try {
      UserCredential result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      String userUid = result.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userUid).set(
          {'uid': userUid, 'name': name, 'profile': profile, 'email': email});
      print('Profile////${profile}');
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    }
  }

  Future Signin(String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: e.message!, gravity: ToastGravity.TOP);
    }
  }

  Future SignOut() async {
    await auth.signOut();
  }

  Future<UserM> getuser(String uid) {
    print('hehe');
    return FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) => UserM.fromJson(value.data()!));
  }
}
