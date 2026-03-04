import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<void> signup(String email, String password) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signIn(String email, String password) async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
  }
}
