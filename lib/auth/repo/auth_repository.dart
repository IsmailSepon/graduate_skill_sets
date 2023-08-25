import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChanges => _auth.authStateChanges();


  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    print('test');
    try {
      final result = await _auth.signInWithEmailAndPassword(email: 'ismail@gmail.com', password: '123456789');
      // print('signInWithEmailAndPassword $email $password');
      final user = result.user;
      return user;
    } catch (e) {
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      final user = result.user;
      print('registerWithEmailAndPassword $email $password');
      return user;
    } catch (e) {
      print("Error: $e");
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}