import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutory/services/api.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/screens/home/user/Models/question.dart';
import 'package:tutory/shared/textstyle.dart';

class OnlineQuiz extends StatefulWidget {
  const OnlineQuiz({Key? key}) : super(key: key);

  @override
  State<OnlineQuiz> createState() => _OnlineQuizState();
}

class _OnlineQuizState extends State<OnlineQuiz> {
  bool loading = false;
  var count = 0;
  String uid = '';
  String udelete = '';
  bool exist = false;
  bool userTwo = false;
  List<Question> finalQues = [];
  List<String> ansChoosed = List.filled(11, '');
  String selected = 'None';
  int i = 0;
  int score = 0;
  String btnTxt = 'Next';
  String choosen = '';
  int netScore = 0;

  Future makeAction() async {
    udelete = await Database(uid: '').getDeleteIdFromQueue();
    await Database(uid: '').popFromQueue(udelete);
    var ques = [];
    List<Question> questions = await Api().startQuiz();
    await Database(uid: '')
        .createGame(udelete, FirebaseAuth.instance.currentUser!.uid, questions);
    finalQues = List.from(questions);
    netScore = finalQues.length * 5;
  }

  void initialize() async {
    setState(() {
      loading = true;
    });
    uid = FirebaseAuth.instance.currentUser!.uid;
    count = await Database(uid: '').checkQueue();
    if (count == 0) {
      Database(uid: '').addUserToQueue(uid);
    } else {
      userTwo = true;
    }

    if (userTwo) {
      await makeAction();
      setState(() {
        userTwo = true;
      });
    }
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return !loading && !userTwo
        ? StreamBuilder<QuerySnapshot>(
            stream: Database(uid: '').checkGameExistence(uid),
            builder: ((context, snapshot) {
              if (snapshot.data != null) {
                snapshot.data!.docs.forEach((element) {
                  if (element.id == uid) {
                    exist = true;
                  } else {
                    exist = false;
                  }
                });
              }
              if (exist) {
                getQues(uid);
                if (finalQues != null && finalQues.length == 11) {
                  return buildCompetitionGui(context, 1);
                } else {
                  return const LoadingShared();
                }
              } else {
                return const LoadingShared();
              }
            }))
        : userTwo
            ? buildCompetitionGui(context, 2)
            : const LoadingShared();
  }

  Future getQues(String uid) async {
    finalQues = await Database(uid: '').getOnlineQuizQuestion(uid);
    if (finalQues != null) {
      ansChoosed = List.filled(finalQues.length, '');
      setState(() {});
    }
  }

  String uidTemp = '';
  Widget buildCompetitionGui(BuildContext context, int flag) {
    flag == 1 ? uidTemp = uid : uidTemp = udelete;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(18),
        child: Column(
          children: [
            SizedBox(
              height: size.height / 10,
            ),
            Text(
              'Question ${i + 1}',
              style: TextStyleShared.questionstyle,
            ),
            SizedBox(
              height: size.height / 50,
            ),
            Text(
              finalQues[i].question,
              style: TextStyleShared.questionstyle,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        choosen = 'A';
                        setState(() {
                          selected = finalQues[i].incorrectAnswers[0];
                        });
                      },
                      child: Text(
                        'A) ${finalQues[i].incorrectAnswers[0]}',
                        style: TextStyleShared.optionStyle,
                      )),
                  TextButton(
                      onPressed: () {
                        choosen = 'B';
                        setState(() {
                          selected = finalQues[i].incorrectAnswers[1];
                        });
                      },
                      child: Text(
                        'B) ${finalQues[i].incorrectAnswers[1]}',
                        style: TextStyleShared.optionStyle,
                      )),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  TextButton(
                      onPressed: () {
                        choosen = 'C';
                        setState(() {
                          selected = finalQues[i].incorrectAnswers[2];
                        });
                      },
                      child: Text(
                        'C) ${finalQues[i].incorrectAnswers[2]}',
                        style: TextStyleShared.optionStyle,
                      )),
                  TextButton(
                      onPressed: () {
                        choosen = 'D';
                        setState(() {
                          selected = finalQues[i].incorrectAnswers[3];
                        });
                      },
                      child: Text(
                        'D) ${finalQues[i].incorrectAnswers[3]}',
                        style: TextStyleShared.optionStyle,
                      )),
                ],
              ),
            ),
            Text(
              'Answer choosed: $selected',
              style: TextStyleShared.choosedStyle,
            ),
            SizedBox(
              height: size.height / 20,
            ),
            Row(
              children: [
                const Expanded(child: SizedBox()),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.green),
                  onPressed: () async {
                    ansChoosed[i] = selected;
                    print(ansChoosed);
                    if (i < finalQues.length - 1) {
                      if (selected == finalQues[i].correctAnswer) {
                        score += 5;
                      }
                      setState(() {
                        i++;
                        //selected = '';
                      });
                    }
                    if (i == finalQues.length - 1) {
                      for (int i = 0; i < 11; i++) {
                        await Database(uid: '')
                            .updateResponses(uidTemp, i, flag, ansChoosed[i]);
                      }
                      showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                                child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'TOTAL SCORE: $score/${netScore.toString()}',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.green),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: ListView.separated(
                                        itemCount: finalQues.length,
                                        itemBuilder: (context, index) {
                                          print(ansChoosed);
                                          return ListTile(
                                            title:
                                                Text(finalQues[index].question),
                                            subtitle: Column(
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                        'A)${finalQues[index].incorrectAnswers[0]}'),
                                                    Text(
                                                        'B)${finalQues[index].incorrectAnswers[1]}')
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Text(
                                                        'C)${finalQues[index].incorrectAnswers[2]}'),
                                                    Text(
                                                        'D)${finalQues[index].incorrectAnswers[3]}')
                                                  ],
                                                ),
                                                Center(
                                                    child: Text(
                                                        'Correct Answer: ${finalQues[index].correctAnswer}')),
                                                Center(
                                                    child: Text(
                                                  'Marked Answer: ${ansChoosed[index]}',
                                                  style: TextStyle(
                                                      color: finalQues[index]
                                                                  .correctAnswer ==
                                                              ansChoosed[index]
                                                          ? Colors.green
                                                          : Colors.red),
                                                )),
                                              ],
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return const Divider(
                                            color: Colors.black,
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ));
                          });
                      //wait for user 2
                      if (flag == 2) {
                        await Database(uid: '').deleteGame(uidTemp);
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(btnTxt),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
