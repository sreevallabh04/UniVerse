import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart'; // For terminating the app

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // User dismissed the dialog, terminate the app
        SystemNavigator.pop(); // Terminate the app
        return null;
      }

      GoogleSignInAuthentication? googleAuth = await googleUser.authentication;

      if (googleUser != null && isValidDomain(googleUser.email)) {
        AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);

        // Save user to Firestore
        await _addUserToFirestore(userCredential.user);

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

  // New function to add user to Firestore
  Future<void> _addUserToFirestore(User? user) async {
    if (user != null) {
      final userDoc = _firestore.collection('users').doc(user.uid);

      await userDoc.set({
        'uid': user.uid,
        'displayName': user.displayName,
        'email': user.email,
        'photoURL': user.photoURL,
        'lastSignIn': FieldValue.serverTimestamp(),
      });
    }
  }
}
