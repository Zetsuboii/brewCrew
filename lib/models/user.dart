import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BrewUser {
  final String uid;

  BrewUser(this.uid);
  BrewUser.fromUser(User userObject) : uid = userObject.uid;
}

class BrewUserData {
  final String uid;
  final String name;
  final String sugars;
  final int strength;

  BrewUserData(this.uid, this.name, this.sugars, this.strength);
  BrewUserData.fromDocumentSnapshot(DocumentSnapshot snap)
      : this.uid = snap.data()['uid'],
        this.name = snap.data()['name'],
        this.strength = snap.data()['strength'],
        this.sugars = snap.data()['sugars'];
}
