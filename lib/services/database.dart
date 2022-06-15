import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:tutory/models/usermodel.dart';

class Database {
  final String uid;
  Database({required this.uid});

  final CollectionReference _userCollection =
      FirebaseFirestore.instance.collection('users');

  //stream for user collection
  Stream<QuerySnapshot?> get userCollectionStream {
    return _userCollection.snapshots();
  }

  //update user-collection data
  Future insertUser(String em, String ps) async {
    await _userCollection.doc(uid).set({'email': em, 'password': ps});
  }

  //admin
  final CollectionReference _admin =
      FirebaseFirestore.instance.collection('admin');

  //admin stream
  Stream<QuerySnapshot> get adminStream {
    return _admin.snapshots();
  }

  //add admin
  Future verifyAdmin(String em, String pass) async {
    List<Map<String, String>> list = [];

    try {
      QuerySnapshot snapshot = await _admin.get(); //get collections
      for (var i in snapshot.docs.toList()) {
        Map<String, String> a = {
          'email': i.get('email'),
          'password': i.get('password')
        };
        list.add(a);
      }
    } catch (e) {
      print(e);
    }
    for (Map i in list) {
      if (i.containsValue(em) && i.containsValue(pass)) {
        return true;
      }
    }
    return false;
  }
}
