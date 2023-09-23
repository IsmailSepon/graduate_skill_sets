
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gp/auth/model/university_model.dart';
import 'package:gp/firestore/firestore_services.dart';

class AuthRepository {
  final FireStoreService fireStoreService = FireStoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // sign in with email and password


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
       var user = result.user;
       // user.displayName = name;
      await user?.updateDisplayName(name);
      await user?.sendEmailVerification();

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

  // register with email and password
  Future<bool> teacherRegisterWithEmailAndPassword(
      String email,
      String password,
      University uni,
      String department,
      String name) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
       var user = result.user;
       // user.displayName = name;
      await user?.updateDisplayName(name);
      await user?.sendEmailVerification();

      saveUser(user!);
      fireStoreService.storeTeacherInformation(
          user, uni, department, name);
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

  Future<User?> login(String email, String password) async {

    try {
      final result =  await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      // User signed in successfully
      final user = result.user;
      return user;

    } catch (e) {
      if (e is FirebaseAuthException) {
        if (e.code == 'user-not-found') {
          // Handle "no user found" exception here
          // For example, show an error message to the user
          print('No user found with this email.');
        } else {
          // Handle other FirebaseAuthException types here
          print('Error: ${e.message}');
        }
      } else {
        // Handle other exceptions not related to Firebase Authentication
        print('Error: $e');
      }
      return null;
    }
  }
}
