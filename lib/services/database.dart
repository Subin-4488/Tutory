import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';
import 'package:tutory/models/leaders.dart';
import 'package:tutory/models/materialmodel.dart';
import 'package:tutory/models/question.dart';
import 'package:tutory/screens/home/user/Models/question.dart' as apiQuestion;

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
        'timestamp': Timestamp.now()
      });
    } else {
      await _materials.doc(material.topic).set({
        'subtopic': material.subtopic,
        'content': material.content,
        'gdrive': material.grive,
      });
    }
  }

  //fetch materials
  Future<List<MaterialModel>> getMaterials(MaterialModel model) async {
    List<MaterialModel> list = [];

    var snapshot = await _materials
        .doc(model.topic)
        .collection(model.subtopic)
        .orderBy('timestamp')
        .get();

    list = snapshot.docs.map((e) {
      return MaterialModel(
          id: '',
          topic: model.topic,
          subtopic: model.subtopic,
          content: e.get('content'),
          grive: e.get('gdrive'));
    }).toList();
    return list;
    // for (var e in data.docs.toList()) {    EITHER USE LOOP OR SIMPLY DO MAP
    //   try {
    //     list.add(MaterialModel(
    //         id: '',
    //         topic: model.topic,
    //         subtopic: model.subtopic,
    //         content: e.get('content'),
    //         grive: e.get('gdrive')));
    //   } catch (e) {
    //     print(e);
    //   }
    // }
    // return list;

    // return data.docs.map((e) {
    //   return MaterialModel(
    //       id: '',
    //       topic: model.topic,
    //       subtopic: model.subtopic,
    //       content: e.get('content'),
    //       grive: e.get('gdrive'));
    // }).toList();
  }

  //ONLINE CONNECTION

  final _queueTable = FirebaseFirestore.instance.collection('Queue');

  Future addUserToQueue(String uid) async {
    await _queueTable.doc(uid).set({'uid': uid});
  }

  Future<int> checkQueue() async {
    QuerySnapshot<Map<String, dynamic>> size = await _queueTable.get();
    return size.docs.length;
  }

  Future popFromQueue(String uid) async {
    _queueTable.doc(uid).delete();
  }

  Future<String> getDeleteIdFromQueue() async {
    Future<String> uid =
        _queueTable.orderBy("uid").limit(1).get().then((snapshot) {
      return snapshot.docs.first.id;
    });
    return uid;
  }

  final _gameTable = FirebaseFirestore.instance.collection("Game");

  Stream<QuerySnapshot>? checkGameExistence(String uid) {
    return _gameTable.snapshots();
  }

  Future createGame(
      String uid1, String uid2, List<apiQuestion.Question> question) async {
    await _gameTable.doc(uid1).set({
      'uid1': uid1,
      'uid2': uid2,
    });
    for (int i = 0; i < question.length; i++) {
      await _gameTable.doc(uid1).collection('questions').doc(i.toString()).set({
        'question': question[i].question,
        'option1': question[i].incorrectAnswers[0],
        'option2': question[i].incorrectAnswers[1],
        'option3': question[i].incorrectAnswers[2],
        'option4': question[i].incorrectAnswers[3],
        'answer': question[i].correctAnswer
      });
      await _gameTable
          .doc(uid1)
          .collection('result1')
          .doc(i.toString())
          .set({'respose': '', 'answer': question[i].correctAnswer});
      await _gameTable
          .doc(uid1)
          .collection('result2')
          .doc(i.toString())
          .set({'response': '', 'answer': question[i].correctAnswer});
    }
  }

  Future<List<apiQuestion.Question>> getOnlineQuizQuestion(String uid) async {
    List<apiQuestion.Question>? questions = [];
    QuerySnapshot? snapshot =
        await _gameTable.doc(uid).collection('questions').get();
    List<dynamic> options = List.filled(4, 0);
    if (snapshot != null) {
      for (var i in snapshot.docs.toList()) {
        List<dynamic> options = List.filled(4, 0);
        options[0] = i.get('option1');
        options[1] = i.get('option2');
        options[2] = i.get('option3');
        options[3] = i.get('option4');
        questions.add(
          apiQuestion.Question(
              categoryName: '',
              correctAnswer: i.get('answer'),
              difficulty: apiQuestion.Difficulty.easy,
              incorrectAnswers: options,
              type: apiQuestion.Type.multiple,
              question: i.get('question')),
        );
      }
    }
    return questions;
  }

  Future updateResponses(String uid, int idx, int user, String response) async {
    print('USER: ${user} : ${uid}');
    if (user == 1) {
      _gameTable
          .doc(uid)
          .collection("result1")
          .doc(idx.toString())
          .set({'response': response});
    } else {
      if (user == 2) {
        _gameTable
            .doc(uid)
            .collection("result2")
            .doc(idx.toString())
            .set({'response': response});
      }
    }
  }

  Future deleteGame(String uid) async {
    await _gameTable.doc(uid).delete();
    await _gameTable.doc(uid).collection('questions').get().then((value)async {
      for (var i in value.docs) {
        await _gameTable.doc(uid).collection('questions').doc(i.id).delete();
      }
    });
    await _gameTable.doc(uid).collection('result1').get().then((value)async {
      for (var i in value.docs) {
        await _gameTable.doc(uid).collection('result1').doc(i.id).delete();
      }
    });
    await _gameTable.doc(uid).collection('result2').get().then((value)async {
      for (var i in value.docs) {
        await _gameTable.doc(uid).collection('result2').doc(i.id).delete();
      }
    });
  }
}
