import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:week4_flutter_app/api/firebase_auth__api.dart';

class UserAuthProvider with ChangeNotifier {
  late FirebaseAuthAPI authService;
  late Stream<User?> userStream;
  User? user;
  String? nameofUser;

  UserAuthProvider() {
    authService = FirebaseAuthAPI();
    userStream = authService.getUserStream();
    userStream.listen((User? user) async {
      this.user = user;
      if (user != null) {
        final userData = await authService.getUserData(user.uid);
        nameofUser = userData?['name'];
      }
      notifyListeners();
    });
  }

  Future<String> signIn(String username, String password) async {
    String message = await authService.signIn(username, password);
    notifyListeners();
    return message;
  }

  Future<String> signUp(String name, String username, String email,
      String password, List<String> contactNumbers) async {
    String message = await authService.signUp(
        name, username, email, password, contactNumbers);
    notifyListeners();
    return message;
  }

  Future<void> signOut(BuildContext context) async {
    await authService.signOut();
    Navigator.popUntil(context, ModalRoute.withName('/'));
    notifyListeners();
  }
}
