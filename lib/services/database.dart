import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tutory/models/leaders.dart';
import 'package:tutory/models/materialmodel.dart';
import 'package:tutory/models/question.dart';

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

  //get leaderrs
  Stream<QuerySnapshot> get getLeaderboard {
    final Stream<QuerySnapshot> stream =
        _leaderboard.orderBy('score', descending: true).snapshots();
    return stream;

    // QuerySnapshot snapshot = await _leaderboard.get();
    // List<Leaders> list=[];

    // try {
    //   snapshot = await _leaderboard.orderBy('score', descending: true).get();

    //   for (var i in snapshot.docs.toList()) {
    //     list.add(Leaders(
    //         email: i.get('email'), score: i.get('score'), uid: i.get('uid')));
    //   }
    // } catch (e) {
    //   print(e);
    // }
    // // list.sort(
    // //   (a, b) {
    // //     return double.parse(a.score).compareTo(double.parse(b.score));
    // //   },
    // // );
    // // list.reversed;
    // return list;
  }

  Future deleteUser() async {
    await _leaderboard.doc(uid).delete();
    await _userCollection.doc(uid).delete();
  }

  //previous year questions from topic

  //fetch questions
  final CollectionReference _prevQuestions =
      FirebaseFirestore.instance.collection('previous year questions');

  Future<List<Question>> getPrevQuestions(String topic, int year) async {
    QuerySnapshot snapshot =
        await _prevQuestions.doc(topic).collection(year.toString()).get();
    List<Question> list = [];

    for (var i in snapshot.docs.toList()) {
      list.add(Question(
          id: i.id,
          topic: i.get('topic'),
          ans: i.get('answer'),
          question: i.get('question'),
          option1: i.get('option 1'),
          option2: i.get('option 2'),
          option3: i.get('option 3'),
          option4: i.get('option 4'),
          year: i.get('year')));
    }
    return list;
  }

  //insert prev year questions questions

  Future insertPrevQuestions(Question question) async {
    await _prevQuestions
        .doc(question.topic)
        .collection(question.year.toString())
        .doc()
        .set({
      'topic': question.topic,
      'year': question.year,
      'question': question.question,
      'answer': question.ans,
      'option 1': question.option1,
      'option 2': question.option2,
      'option 3': question.option3,
      'option 4': question.option4
    });
  }

  //update previous year question

  Future updatePrevQuestions(Question question) async {
    await _prevQuestions
        .doc(question.topic)
        .collection(question.year.toString())
        .doc(question.id)
        .set({
      'topic': question.topic,
      'year': question.year,
      'question': question.question,
      'answer': question.ans,
      'option 1': question.option1,
      'option 2': question.option2,
      'option 3': question.option3,
      'option 4': question.option4
    });
  }

  //Materials

  final CollectionReference _materials =
      FirebaseFirestore.instance.collection('Materials');

  //add materials
  Future addMaterials(MaterialModel material) async {
    if (material.subtopic.length > 0) {
      await _materials
          .doc(material.topic)
          .collection(material.subtopic)
          .doc()
          .set({
        'subtopic': material.subtopic,
        'content': material.content,
        'gdrive': material.grive,
      });
    } else {
      await _materials
          .doc(material.topic)
          .set({
        'subtopic': material.subtopic,
        'content': material.content,
        'gdrive': material.grive,
      });
    }
  }
}
