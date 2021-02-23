import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_brewcrewnew/models/brew.dart';
import 'package:flutter_brewcrewnew/models/user.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});
  // collection reference
  // call collection 'brews' from firestore
  final CollectionReference brewCollection =
      FirebaseFirestore.instance.collection('brews');
  // only one table is needed

  Future updateUserData(String sugars, String name, int strength) async {
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  // brewlist from snapshot
  List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((e) => Brew.fromDoc(e)).toList();
  }

  // get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewListFromSnapshot);
  }

  // get user doc stream
  Stream<BrewUserData> get userData {
    var snap = brewCollection.doc(uid).snapshots();
    // .map() function can open Streams
    return snap.map((sn) => BrewUserData.fromDocumentSnapshot(sn));
  }
}
