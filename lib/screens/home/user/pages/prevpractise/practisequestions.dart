import 'package:flutter/material.dart';
import 'package:tutory/models/question.dart';
import 'package:tutory/screens/home/user/pages/Quiz.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/shared/textstyle.dart';

class PractiseQuestions extends StatefulWidget {
  final String topic;
  final int year;
  const PractiseQuestions({Key? key, required this.topic, required this.year})
      : super(key: key);

  @override
  State<PractiseQuestions> createState() => _PractiseQuestionsState();
}

class _PractiseQuestionsState extends State<PractiseQuestions> {
  bool loading = true;
  List<Question> questions = [];
  String selected = 'None';
  int i = 0;
  int score = 0;
  String btnTxt = 'Next';
  String choosen = '';
  List<String> ansChoosed = List.filled(1, '');
  int netScore = 0;

  void prepare() async {
    // TODO: implement initState
    questions =
        await Database(uid: '').getPrevQuestions(widget.topic, widget.year);
    netScore = questions.length*5;
    ansChoosed = List.filled(questions.length, '');
    setState(() {
      loading = !loading;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    prepare();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return loading
        ? const LoadingShared()
        :questions.isEmpty? 
        Scaffold(body: Container(alignment: Alignment.center,
        child: const Text('No data found!!',style: TextStyle(
          fontSize: 18
        ),)),)
        : Scaffold(
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
                  questions[i].question,
                  style: TextStyleShared.questionstyle,
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            choosen = 'A';
                            setState(() {
                              selected = questions[i].option1;
                            });
                          },
                          child: Text(
                            'A) ${questions[i].option1}',
                            style: TextStyleShared.optionStyle,
                          )),
                      const Expanded(child: SizedBox()),
                      TextButton(
                          onPressed: () {
                            choosen = 'B';
                            setState(() {
                              selected = questions[i].option2;
                            });
                          },
                          child: Text(
                            'B) ${questions[i].option2}',
                            style: TextStyleShared.optionStyle,
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            choosen = 'C';
                            setState(() {
                              selected = questions[i].option3;
                            });
                          },
                          child: Text(
                            'C) ${questions[i].option3}',
                            style: TextStyleShared.optionStyle,
                          )),
                      const Expanded(child: const SizedBox()),
                      TextButton(
                          onPressed: () {
                            choosen = 'D';
                            setState(() {
                              selected = questions[i].option4;
                            });
                          },
                          child: Text(
                            'D) ${questions[i].option4}',
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
                    ElevatedButton(
                      onPressed: () {
                        if (score > 0) {
                          score -= 5;
                        }

                        if (i > 0) {
                          setState(() {
                            i--;
                            selected = '';
                            btnTxt = 'Next';
                          });
                        }
                        print(score);
                        choosen = '';
                      },
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                      child: const Text('Previous'),
                    ),
                    const Expanded(child: SizedBox()),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                      onPressed: () {
                        //ansChoosed.add(choosen.toString());
                        ansChoosed[i] = choosen;
                        if (i < questions.length - 1) {
                          if (choosen == questions[i].ans) {
                            score += 5;
                          }
                          setState(() {
                            i++;
                            selected = '';
                          });
                          //print(score);

                        }
                        if (i == questions.length - 1) {
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
                                            itemCount: questions.length,
                                            itemBuilder: (context, index) {
                                              return ListTile(
                                                title: Text(
                                                    questions[index].question),
                                                subtitle: Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('A)${questions[index]
                                                            .option1}'),
                                                        Text('B)${questions[index]
                                                            .option2}')
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text('C)${questions[index]
                                                            .option3}'),
                                                        Text('D)${questions[index]
                                                            .option4}')
                                                      ],
                                                    ),
                                                    Center(
                                                        child: Text(
                                                            'Correct Answer: ${questions[index].ans}')),
                                                    Center(
                                                        child: Text(
                                                            'Marked Answer: ${ansChoosed[index]}',
                                                            style: TextStyle(
                                                              color:questions[index].ans==ansChoosed[index]?
                                                              Colors.green:Colors.red
                                                            ),)),
                                                    
                                                  ],
                                                ),
                                              );
                                            },
                                            separatorBuilder:
                                                (BuildContext context,
                                                    int index) {
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
                          Navigator.pop(context);
                          setState(() {
                            btnTxt = 'Submit';
                          });
                        } else {
                          setState(() {
                            btnTxt = 'Next';
                          });
                        }
                        print(score);
                      },
                      child: Text(btnTxt),
                    )
                  ],
                )
              ],
            ),
          ));
  }
}
