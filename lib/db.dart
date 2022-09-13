import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:async';
import 'models.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

/*
  Future<List<skica>> getskica() async {
    final querySnapshot =
        await FirebaseFirestore.instance.collection('profiles').get();
    List<QueryDocumentSnapshot> docs = querySnapshot.docs;

    final skicaList = docs
        .map((doc) => skica.fromJson(doc.data()! as Map<String, dynamic>))
        .toList();
    return skicaList;
  }
   */

  Future<void> addSkica(dynamic skica) {
    return _db.collection('profiles').add(skica);
  }
}
