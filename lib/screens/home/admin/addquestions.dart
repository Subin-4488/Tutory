import 'package:flutter/material.dart';
import 'package:tutory/shared/optiontextformfielddecorator.dart';

class AddQuestions extends StatefulWidget {
  const AddQuestions({Key? key}) : super(key: key);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  String _ques = '';
  String _op1 = '';
  String _op2 = '';
  String _op3 = '';
  String _op4 = '';

  List<int> _year = [];
  int _selectedyear = 2000;

  List<String> _correctAnswer = ['A', 'B', 'C', 'D'];
  String _correctOption = 'A';

  final _key = GlobalKey<FormState>();

  Color ca = Colors.deepPurple;
  Color cb = Colors.deepPurple;
  Color cc = Colors.deepPurple;
  Color cd = Colors.deepPurple;

  void _addyear() {
    _year.clear();
    for (int i = 2000; i <= 2022; i++) {
      _year.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    _addyear();

    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          Expanded(
            child: SizedBox(),
          ),
          Container(
              margin: EdgeInsets.only(left: size.width / 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                'ADD QUESTION',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              )),
          Container(
            margin: const EdgeInsets.only(top: 18),
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                      validator: (txt) {
                        if (txt!.isEmpty) return "Enter field";
                        return null;
                      },
                      onChanged: (txt) {
                        _ques = txt;
                      },
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
                          labelText: 'Question',
                          hintText: 'Add previous year question')),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            validator: (txt) {
                              if (txt!.isEmpty) return "Enter field";
                              return null;
                            },
                            onChanged: (txt) {
                              _op1 = txt;
                            },
                            decoration:
                                OptionsDecorator(color: ca, label: 'Option A')
                                    .getOptionsDecorator()),
                      ),
                      SizedBox(
                        width: size.width / 10,
                      ),
                      Expanded(
                        child: TextFormField(
                            validator: (txt) {
                              if (txt!.isEmpty) return "Enter field";
                              return null;
                            },
                            onChanged: (txt) {
                              _op2 = txt;
                            },
                            decoration:
                                OptionsDecorator(color: cb, label: 'Option B')
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
                            validator: (txt) {
                              if (txt!.isEmpty) return "Enter field";
                              return null;
                            },
                            onChanged: (txt) {
                              _op3 = txt;
                            },
                            decoration:
                                OptionsDecorator(color: cc, label: 'Option C')
                                    .getOptionsDecorator()),
                      ),
                      SizedBox(
                        width: size.width / 10,
                      ),
                      Expanded(
                        child: TextFormField(
                            validator: (txt) {
                              if (txt!.isEmpty) return "Enter field";
                              return null;
                            },
                            onChanged: (txt) {
                              _op4 = txt;
                            },
                            decoration:
                                OptionsDecorator(color: cd, label: 'Option D')
                                    .getOptionsDecorator()),
                      )
                    ],
                  ),
                  //dropdown for question year
                  Row(
                    children: [
                      const Text(
                        ' YEAR:   ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height / 8,
                      ),
                      DropdownButton(
                          elevation: 1,
                          dropdownColor: Colors.deepPurple,
                          icon: const Icon(Icons.timelapse),
                          value: _selectedyear,
                          items: _year.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            );
                          }).toList(),
                          onChanged: (int? e) {
                            setState(() {
                              _selectedyear = e!;
                            });
                          }),
                      const Expanded(
                        child: SizedBox(),
                      ),
                      const Text(
                        ' CORRECT\n ANSWER:   ',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: size.height / 8,
                      ),
                      DropdownButton(
                          elevation: 1,
                          dropdownColor: Colors.deepPurple,
                          //icon: const Icon(Icons.leaderboard),
                          value: _correctOption,
                          items: _correctAnswer.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(
                                e,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? e) {
                            setState(() {
                              _correctOption = e!;

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
                            });
                          }),
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
                                    title: const Text('CONFIRM TO SUBMIT'),
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: Colors.green
                                              ),
                                                onPressed: () {},
                                                child: const Text('Confirm')),
                                          ),
                                          Expanded(child: SizedBox()),
                                          Expanded(
                                            child: ElevatedButton(
                                               style: ElevatedButton.styleFrom(
                                                primary: Colors.deepPurple
                                              ),
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: const Text('Cancel')),
                                          ),
                                        ],
                                      )
                                    ],
                                  );
                                });
                          }
                        },
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: size.height / 6,
            ),
          ),
        ],
      ),
    );
  }
}
