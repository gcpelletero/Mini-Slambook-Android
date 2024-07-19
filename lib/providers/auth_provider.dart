import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../api/firebase_auth__api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> userStream;
  User? user;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    userStream = authService.getUserStream();
  }

//CHANGED
  Future<String> signIn(String username, String password) async {
    String message = await authService.signIn(username, password);
    notifyListeners();
    return message;
  }

//CHANGED
  Future<String> signUp(String name, String username, String email,
      String password, List<String> contactNumbers) async {
    String message = await authService.signUp(
        name, username, email, password, contactNumbers);
    notifyListeners();
    return message;
  }

  Future<void> signOut() async {
    await authService.signOut();
    //CHANGES
    notifyListeners();
  }
}
