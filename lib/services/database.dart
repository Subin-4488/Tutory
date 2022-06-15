import 'package:cloud_firestore/cloud_firestore.dart';
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
    await _userCollection.doc(uid).set({
      'email': em,
      'password' : ps
    });
  }
}
