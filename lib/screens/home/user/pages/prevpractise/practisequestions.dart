import 'package:flutter/material.dart';
import 'package:tutory/models/question.dart';
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
  String _buttonNext = 'Next';
  int _score = 0;

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
        ? const LoadingShared()
        : Scaffold(
            body: Container(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                Container(
                  height: size.height / 1.7,
                  child: SingleChildScrollView(
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
                        Container(
                            alignment: Alignment.centerRight,
                            width: double.infinity,
                            child: const Text(
                              '\nMarks: 1',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 15,
                              ),
                            )),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selected =
                                              questions[i].option1.trim();
                                        });
                                      },
                                      child: Text(
                                        'A) ${questions[i].option1}',
                                        style: TextStyleShared.optionStyle,
                                      )),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selected =
                                              questions[i].option2.trim();
                                        });
                                      },
                                      child: Text(
                                        'B) ${questions[i].option2}',
                                        style: TextStyleShared.optionStyle,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selected =
                                              questions[i].option3.trim();
                                        });
                                      },
                                      child: Text(
                                        'C) ${questions[i].option3}',
                                        style: TextStyleShared.optionStyle,
                                      )),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Expanded(
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          selected =
                                              questions[i].option4.trim();
                                        });
                                      },
                                      child: Text(
                                        'D) ${questions[i].option4}',
                                        style: TextStyleShared.optionStyle,
                                      )),
                                ),
                              ),
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
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (i > 0) {
                            setState(() {
                              i--;
                            });
                            if (_buttonNext.compareTo('Next') != 0)
                              setState(() => _buttonNext = 'Next');
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: const Text('Previous'),
                      ),
                      const Expanded(child: SizedBox()),
                      ElevatedButton(
                        onPressed: () {
                          if (i < questions.length - 1) {
                            setState(() {
                              i++;
                              if (i == questions.length - 1) {
                                setState(() => _buttonNext = 'Submit');
                              }
                            });
                            updateScore('++');
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.green),
                        child: Text(_buttonNext),
                      )
                    ],
                  ),
                )
              ],
            ),
          ));
  }

  void updateScore(String operation) {
    if (operation.compareTo('++')==0){
      
    }
    else{

    }
  }
}
