

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;
  Stream<User?> get authStateChages =>_auth.authStateChanges();

  // Future<void> signUp(String email, String password) async {
  // await _auth.createUserWithEmailAndPassword(
  //     email: email,
  //     password: password,
  // );}

  Future<void> signUp(String email, String password, BuildContext context ) async {
  try {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    debugPrint('Signed up}');
   
  } on FirebaseAuthException catch (e) {
    showErrorSnackBar(context, e.message!);
    debugPrint('Sign up error: ${e.code} - ${e.message}');
    
  
    throw Exception(_getSignUpErrorMessage(e.code));
  } catch (e) {
    showErrorSnackBar(context,'Unexpected sign up error: $e');
    
    throw Exception("Something went wrong. Try again.");
    
  }
}

 Future<void> signIn(String email, String password, context) async {
  try{
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    showErrorSnackBar(context, e.message!);
    
    throw Exception(_getSignUpErrorMessage(e.code));
  } catch (e) {
    showErrorSnackBar(context,'Unexpected sign up error: $e');
    
    throw Exception("Something went wrong. Try again.");
    
  }
      
    
  }

  Future<void> signOut() async {
      await _auth.signOut();
    
  }
}


String _getSignUpErrorMessage(String code) {
  switch (code) {
    case 'email-already-in-use':
      return 'This email is already in use.';
    case 'invalid-email':
      return 'The email address is not valid.';
    case 'operation-not-allowed':
      return 'Email/password sign-up is disabled.';
    case 'weak-password':
      return 'The password is too weak. Try a stronger one.';
    default:
      return 'Sign up failed. Try again.';
  }
}


void showErrorSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
    ),
  );
}