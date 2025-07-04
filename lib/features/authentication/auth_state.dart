import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class AuthNotifier extends ChangeNotifier {
  bool _isLoggedIn = FirebaseAuth.instance.currentUser != null;
  bool get isLoggedIn => _isLoggedIn;

  User? _user = FirebaseAuth.instance.currentUser;
  User? get currentUser => _user;

  AuthNotifier() {
    FirebaseAuth.instance.authStateChanges().listen((firebaseUser) {
      _isLoggedIn = firebaseUser != null;
      _user = firebaseUser;
      notifyListeners();
    });
  }
}
