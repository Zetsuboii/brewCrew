import 'package:cloud_firestore/cloud_firestore.dart';

class Brew {
  final String name;
  final String sugars;
  final int strength;

  Brew({this.name, this.sugars, this.strength});
  Brew.fromDoc(QueryDocumentSnapshot doc)
      : this.name = doc.data()['name'] ?? '',
        this.sugars = doc.data()['sugars'] ?? '0',
        this.strength = doc.data()['strength'] ?? 0;
}
