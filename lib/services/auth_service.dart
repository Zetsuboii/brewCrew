import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_brewcrewnew/models/user.dart';
import 'package:flutter_brewcrewnew/services/database_service.dart';

class AuthService {
  // Instantiate firebase authentication helper
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // auth change user stream
  Stream<BrewUser> get user {
    return _auth.authStateChanges().map((User user) => BrewUser.fromUser(user));
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user;
      return user != null ? BrewUser.fromUser(user) : null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User signedUser = result.user;
      return BrewUser.fromUser(signedUser);
    } catch (e) {
      print('There is an error lolll');
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithCredentials(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User newUser = result.user;
      // new User is created at this moment
      await DatabaseService(uid: newUser.uid)
          .updateUserData('0', 'New Crew Member', 100);
      return BrewUser.fromUser(newUser);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
