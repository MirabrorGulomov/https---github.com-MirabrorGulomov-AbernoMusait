import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUpWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> logInWithEmailAndPassword(
      String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> updateUserName(String displayName) async {
    User? user = FirebaseAuth.instance.currentUser;
    await user?.updateDisplayName(displayName);
    await user?.reload();
  }

  Future<User?> getCurrentUser()async{
    return _firebaseAuth.currentUser;
  }

  Stream<User?> get user => _firebaseAuth.authStateChanges();
}
