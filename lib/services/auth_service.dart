import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  // instance of FirebaseAuth
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() {
    return _auth.currentUser;
  }

  // Sign in with email and password
  Future<UserCredential> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("${e.code}: ${e.message}");
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw Exception("${e.code}: ${e.message}");
    }
  }

  // sign up with email and password
  Future<UserCredential> signUpWithEmailAndPassword(
    String name,
    String email,
    String password,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      final user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'name': name.trim(), // ✅ REAL NAME
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw Exception("${e.code}: ${e.message}");
    }
  }
}
