import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  final FirebaseAuth _firebaseAuth;
  AuthServices(this._firebaseAuth);

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // UserModel _userFromFirebase(User user) {
  //   return user != null ? UserModel(uid: user.uid) : null;
  // }

  Future<String?> signIn({required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return 'Signed In';
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  Future<void> signOut() async {
    _firebaseAuth.signOut();
  }

  // Future<Wrapper> signOut() async {
  //   await FirebaseAuth.instance.signOut();
  //   return new Wrapper();
  // }

  // Future<String> signUp({String email, String password}) async {
  //   try {
  //     await _firebaseAuth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //     return 'Signed Up';
  //   } on FirebaseAuthException catch (e) {
  //     return e.message;
  //   }
  // }
}
