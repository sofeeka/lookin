import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? get currentUser => _firebaseAuth.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<bool> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      print("Error signing in: $e");
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future createImageLink({
    required String? imageLink,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('images');

    QuerySnapshot querySnapshot =
        await users.where('url', isEqualTo: imageLink).get();

    if (querySnapshot.docs.isNotEmpty) {
      print('Query snapshot is not empty');
      return false;
    } else {
      try {
        if (currentUser != null) {
          print('Current user is not null');
          await users.doc(currentUser?.uid).set({'url': imageLink});
          return true;
        } else {
          print('Current user is null');
          return false;
        }
      } catch (e) {
        throw Exception('Error adding avatar: $e');
      }
    }
  }

  Future<bool> createUsername({
    required String username,
  }) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    QuerySnapshot querySnapshot =
        await users.where('username', isEqualTo: username).get();

    if (querySnapshot.docs.isNotEmpty) {
      return false;
    } else {
      try {
        if (currentUser != null) {
          await users.doc(currentUser?.uid).set({'username': username});
          return true;
        } else {
          return false;
        }
      } catch (e) {
        throw Exception('Error adding username: $e');
      }
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
