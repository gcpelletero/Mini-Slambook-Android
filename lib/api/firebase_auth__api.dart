import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthAPI {
  final FirebaseAuth auth = FirebaseAuth.instance;
  //changes
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<User?> getUserStream() {
    return auth.authStateChanges();
  }

  User? getUser() {
    return auth.currentUser;
  }

//CHANGED
  Future<String> signIn(String username, String password) async {
    try {
      QuerySnapshot result = await firestore
          .collection('users')
          .where('username', isEqualTo: username)
          .get();
      if (result.docs.isEmpty) {
        return "Username not found";
      }
      String email = result.docs.first['email'];
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Successfully signed in!";
    } on FirebaseAuthException catch (e) {
      return "Failed at error ${e.code}";
    }
  }

//CHANGED
  Future<String> signUp(String name, String username, String email,
      String password, List<String> contactNumbers) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = auth.currentUser;

      await firestore.collection('users').doc(user?.uid).set({
        'name': name,
        'username': username,
        'email': email,
        'contactNumbers': contactNumbers,
      });

      return "Successfully signed up!";
    } on FirebaseAuthException catch (e) {
      return "Failed at error ${e.code}";
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  Future<Map<String, dynamic>?> getUserData(String uid) async {
    DocumentSnapshot userDoc =
        await firestore.collection('users').doc(uid).get();
    return userDoc.data() as Map<String, dynamic>?;
  }
}
