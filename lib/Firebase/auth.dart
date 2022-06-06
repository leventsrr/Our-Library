import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  late var userInformation;
  changeUserInformation(var credential) {
    userInformation = credential;
  }

  String reachToUserUid() {
    return userInformation.user!.uid;
  }

  reachUser() {
    return userInformation;
  }

  final _firebaseAuth = FirebaseAuth.instance;
  Future<UserCredential> signUp(email, password) async {
    var userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  Future<UserCredential> signInWithEmailAndPassword(email, password) async {
    var userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    return userCredential;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  resetPassword(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  deleteAccount(User? user) async {
    await user!.delete();
  }
}
