import 'dart:ffi';

import 'package:aad_oauth/aad_oauth.dart';
import 'package:aad_oauth/model/config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/firestore/firestore_services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthRepository {
  final FireStoreService fireStoreService = FireStoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //
  // final FirebaseDatabase database = FirebaseDatabase.instance;
  // final DatabaseReference _universityReference = FirebaseDatabase.instance.ref('gp').child('university');
  // CollectionReference collection = FirebaseFirestore.instance.collection('gp');
  //
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  // final List<University> list = [];
  // User? get currentUser => _auth.currentUser;
  // Stream<User?> get authStateChanges => _auth.authStateChanges();

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
          email: 'ismail@gmail.com', password: '123456789');
      // print('signInWithEmailAndPassword $email $password');
      final user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future<bool> registerWithEmailAndPassword(
      String email,
      String password,
      University uni,
      String department,
      String studentId,
      String dateOfBirth,
      String name) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = result.user;
      saveUser(user!);
      fireStoreService.storeInformation(
          user, uni, department, studentId, dateOfBirth, name);
      print('registerWithEmailAndPassword $email $password');
      return true;
    } catch (e) {
      print("Error: $e");
      return false;
    }
  }

  Future<List<University>> getUniversityList() async {
    return await fireStoreService.getUniversityList();
  }


  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  void saveUser(User user) {}

  login(String email, String password) async {
    final result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = result.user;
    saveUser(user!);
  }
}
