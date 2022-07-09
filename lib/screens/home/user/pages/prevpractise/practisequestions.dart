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

  void prepare() async {
    // TODO: implement initState
    questions =
        await Database(uid: '').getPrevQuestions(widget.topic, widget.year);
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
        ? LoadingShared()
        : Scaffold(
            body: Container(
            padding: EdgeInsets.all(18),
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              selected = questions[i].option1;
                            });
                          },
                          child: Text(
                            'A) ${questions[i].option1}',
                            style: TextStyleShared.optionStyle,
                          )),
                      Expanded(child: SizedBox()),
                      TextButton(
                          onPressed: () {
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              selected = questions[i].option3;
                            });
                          },
                          child: Text(
                            'C) ${questions[i].option3}',
                            style: TextStyleShared.optionStyle,
                          )),
                      Expanded(child: SizedBox()),
                      TextButton(
                          onPressed: () {
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
                        if (i > 0) {
                          setState(() {
                            i--;
                          });
                        }
                      },
                      child: Text('Previous'),
                      style: ElevatedButton.styleFrom(primary: Colors.black),
                    ),
                    Expanded(child: SizedBox()),
                    ElevatedButton(
                      onPressed: () {
                        if (i < questions.length) {
                          print(questions.length);
                          print(i);
                          setState(() {
                            i++;
                          });
                        }
                      },
                      child: Text('Next'),
                      style: ElevatedButton.styleFrom(primary: Colors.green),
                    )
                  ],
                )
              ],
            ),
          ));
  }
}
