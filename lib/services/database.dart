import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutory/models/leaders.dart';

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
    //create leader collection doc with score = 0
    _addLeaderboardEntry(em);
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

  //leaderboard

  final CollectionReference _leaderboard =
      FirebaseFirestore.instance.collection('leaderboard');

  //create leaderboard during registration

  Future _addLeaderboardEntry(String email) async {
    //entry with score = 0 for new user
    _leaderboard.doc(uid).set({'uid': uid, 'score': '0', 'email': email});
  }

  //get leaders
  Future<List<Leaders>> getLeaderboard() async {
    List<Leaders> list = [];
    QuerySnapshot snapshot;

    try {
      snapshot = await _leaderboard.get();
      for (var i in snapshot.docs.toList()) {
        list.add(Leaders(
            email: i.get('email'), score: i.get('score'), uid: i.get('uid')));
      }
    } catch (e) {
      print(e);
    }
    // list.sort(
    //   (a, b) {
    //     return double.parse(a.score).compareTo(double.parse(b.score));
    //   },
    // );
    // list.reversed;
    return list;
  }

  Future deleteUser() async {
    await _leaderboard.doc(uid).delete();
    await _userCollection.doc(uid).delete();
  }
}
