import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutory/models/question.dart';
import 'package:tutory/screens/home/admin/screens/questions.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/shared/optiontextformfielddecorator.dart';

class AddQuestions extends StatefulWidget {
  final bool flag;
  final Question question;
  AddQuestions({Key? key, required this.question, required this.flag})
      : super(key: key);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  String _ques = '';
  String _op1 = '';
  String _op2 = '';
  String _op3 = '';
  String _op4 = '';
  String _topic = '';
  int _yr = -1;

  final List<int> _year = [];

  final List<String> _correctAnswer = ['A', 'B', 'C', 'D'];
  String _correctOption = 'A';
  bool loading = false;
  bool entered=false;

  final _key = GlobalKey<FormState>();

  Color ca = Colors.deepPurple;
  Color cb = Colors.deepPurple;
  Color cc = Colors.deepPurple;
  Color cd = Colors.deepPurple;

  @override
  void initState() {
    //super.initState();
    _year.clear();
    for (int i = 2000; i <= 2022; i++) {
      _year.add(i);
    }
    if (widget.flag && !entered) {
      _ques = widget.question.question;
      _op1 = widget.question.option1;
      _op2 = widget.question.option2;
      _op3 = widget.question.option3;
      _op4 = widget.question.option4;
      _correctOption = widget.question.ans;
      _topic = widget.question.topic;
      _yr = widget.question.year;
        if (_correctOption == 'A')
          ca = Colors.green;
        else if (_correctOption == 'B')
          cb = Colors.green;
        else if (_correctOption == 'C')
          cc = Colors.green;
        else if (_correctOption == 'D') cd = Colors.green;
        entered=true;
      }
    }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text(
          'ADD QUESTION',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: loading
          ? Center(child: LoadingShared())
          : SingleChildScrollView(
              child: Material(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: size.height / 40),
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              TextFormField(
                                  initialValue: widget.flag ? _ques : '',
                                  maxLines: null,
                                  validator: (txt) {
                                    if (txt!.isEmpty) return "Enter field";
                                    return null;
                                  },
                                  onChanged: (txt) {
                                    _ques = txt;
                                  },
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(8))),
                                      labelText: 'Question',
                                      hintText: 'Add previous year question')),
                              SizedBox(
                                height: size.height / 40,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                        initialValue: widget.flag ? _op1 : '',
                                        maxLines: null,
                                        validator: (txt) {
                                          if (txt!.isEmpty)
                                            return "Enter field";
                                          return null;
                                        },
                                        onChanged: (txt) {
                                          _op1 = txt;
                                        },
                                        decoration: OptionsDecorator(
                                                color: ca, label: 'Option A')
                                            .getOptionsDecorator()),
                                  ),
                                  SizedBox(
                                    width: size.width / 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                        initialValue: widget.flag ? _op2 : '',
                                        maxLines: null,
                                        validator: (txt) {
                                          if (txt!.isEmpty)
                                            return "Enter field";
                                          return null;
                                        },
                                        onChanged: (txt) {
                                          _op2 = txt;
                                        },
                                        decoration: OptionsDecorator(
                                                color: cb, label: 'Option B')
                                            .getOptionsDecorator()),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: size.height / 60,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                        initialValue: widget.flag ? _op3 : '',
                                        maxLines: null,
                                        validator: (txt) {
                                          if (txt!.isEmpty)
                                            return "Enter field";
                                          return null;
                                        },
                                        onChanged: (txt) {
                                          _op3 = txt;
                                        },
                                        decoration: OptionsDecorator(
                                                color: cc, label: 'Option C')
                                            .getOptionsDecorator()),
                                  ),
                                  SizedBox(
                                    width: size.width / 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                        initialValue: widget.flag ? _op4 : '',
                                        maxLines: null,
                                        validator: (txt) {
                                          if (txt!.isEmpty)
                                            return "Enter field";
                                          return null;
                                        },
                                        onChanged: (txt) {
                                          _op4 = txt;
                                        },
                                        decoration: OptionsDecorator(
                                                color: cd, label: 'Option D')
                                            .getOptionsDecorator()),
                                  )
                                ],
                              ),
                              //dropdown for question year
                              Row(
                                children: [
                                  const Text(
                                    ' CORRECT\n ANSWER:   ',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: size.height / 8,
                                  ),
                                  DropdownButton(
                                      elevation: 0,
                                      dropdownColor:
                                          const Color.fromARGB(255, 48, 48, 48),
                                      //icon: const Icon(Icons.leaderboard),
                                      value: _correctOption,
                                      items: _correctAnswer.map((e) {
                                        return DropdownMenuItem(
                                          value: e,
                                          child: Text(
                                            e,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? e) {
                                        setState(() {
                                          _correctOption = e!;
                                        });

                                        if (_correctOption == 'A') {
                                          setState(() {
                                            ca = Colors.green;
                                            cb = Colors.deepPurpleAccent;
                                            cc = Colors.deepPurpleAccent;
                                            cd = Colors.deepPurpleAccent;
                                          });
                                        } else if (_correctOption == 'B') {
                                          setState(() {
                                            cb = Colors.green;
                                            ca = Colors.deepPurpleAccent;
                                            cc = Colors.deepPurpleAccent;
                                            cd = Colors.deepPurpleAccent;
                                          });
                                        } else if (_correctOption == 'C') {
                                          setState(() {
                                            cc = Colors.green;
                                            cb = Colors.deepPurpleAccent;
                                            ca = Colors.deepPurpleAccent;
                                            cd = Colors.deepPurpleAccent;
                                          });
                                        } else if (_correctOption == 'D') {
                                          setState(() {
                                            cd = Colors.green;
                                            cb = Colors.deepPurpleAccent;
                                            cc = Colors.deepPurpleAccent;
                                            ca = Colors.deepPurpleAccent;
                                          });
                                        }
                                      })
                                ],
                              ),
                              Container(
                                width: size.width / 1.5,
                                child: ElevatedButton(
                                    onPressed: () {
                                      if (_key.currentState!.validate()) {
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return SimpleDialog(
                                                title: const Text(
                                                    'CONFIRM TO SUBMIT'),
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Colors
                                                                        .green),
                                                            onPressed:
                                                                () async {
                                                              if (widget.flag) {
                                                                setState(() {
                                                                  loading =
                                                                      true;
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                await Database(
                                                                        uid: '')
                                                                    .updatePrevQuestions(Question(
                                                                      id:
                                                                      widget.question.id ,
                                                                        topic:
                                                                            _topic,
                                                                        ans:
                                                                            _correctOption,
                                                                        question:
                                                                            _ques,
                                                                        option1:
                                                                            _op1,
                                                                        option2:
                                                                            _op2,
                                                                        option3:
                                                                            _op3,
                                                                        option4:
                                                                            _op4,
                                                                        year:
                                                                            _yr));
                                                                setState(() {
                                                                  loading =
                                                                      false;
                                                                });
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            'Question updated successfully');
                                                              } else {
                                                                setState(() {
                                                                  loading =
                                                                      true;
                                                                });
                                                                Navigator.of(
                                                                        context)
                                                                    .pop();
                                                                await Database(uid: '')
                                                                .insertPrevQuestions(Question(
                                                                  id: '',
                                                                    topic: widget
                                                                        .question
                                                                        .topic,
                                                                    question:
                                                                        _ques,
                                                                    ans:
                                                                        _correctOption,
                                                                    option1:
                                                                        _op1,
                                                                    option2:
                                                                        _op2,
                                                                    option3:
                                                                        _op3,
                                                                    option4:
                                                                        _op4,
                                                                    year: widget
                                                                        .question
                                                                        .year));
                                                                setState(() {
                                                                  loading =
                                                                      false;
                                                                });
                                                                Fluttertoast
                                                                    .showToast(
                                                                        msg:
                                                                            'Question submitted successfully');
                                                              }
                                                            },
                                                            child: const Text(
                                                                'Confirm')),
                                                      ),
                                                      const Expanded(
                                                          child: SizedBox()),
                                                      Expanded(
                                                        child: ElevatedButton(
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    primary: Colors
                                                                        .deepPurple),
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cancel')),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              );
                                            });
                                      }
                                    },
                                    child: Text(
                                      widget.flag ? 'UPDATE' : 'SUBMIT',
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
