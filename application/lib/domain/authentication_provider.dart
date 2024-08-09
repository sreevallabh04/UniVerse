import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleUser != null && isValidDomain(googleUser.email)) {
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        notifyListeners();
        return userCredential;
      } else {
        await _googleSignIn.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Sign in with a valid email")));
      }
    } catch (e) {
      print('Error during Google Sign-In: $e');
    }
    return null;
  }

  Future<void> signOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    notifyListeners();
  }

  bool isValidDomain(String userEmail) {
    final allowedDomains = ['vitstudent.ac.in', 'vit.ac.in'];
    return allowedDomains.contains(userEmail.split('@')[1]);
  }

  User? get currentUser => _auth.currentUser;

  Future<bool> isUserSignedIn() async {
    return _auth.currentUser != null;
  }
}
