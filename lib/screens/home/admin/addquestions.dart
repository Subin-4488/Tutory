import 'package:flutter/material.dart';

class AddQuestions extends StatefulWidget {
  const AddQuestions({Key? key}) : super(key: key);

  @override
  State<AddQuestions> createState() => _AddQuestionsState();
}

class _AddQuestionsState extends State<AddQuestions> {
  List<String> topics = [''];
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      child: Column(
        children: [
          SizedBox(
            height: size.height / 6,
          ),
          Container(
              margin: EdgeInsets.only(left: size.width / 10),
              alignment: Alignment.centerLeft,
              child: const Text(
                'ADD QUESTION',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              )),
          Container(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  TextFormField(
                      validator: (txt) {},
                      onChanged: (txt) {},
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        labelText: 'Question',
                      )),
                  SizedBox(
                    height: size.height / 40,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            validator: (txt) {},
                            onChanged: (txt) {},
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Option a',
                            )),
                      ),
                      SizedBox(
                        width: size.width / 10,
                      ),
                      Expanded(
                        child: TextFormField(
                            validator: (txt) {},
                            onChanged: (txt) {},
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Option b',
                            )),
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
                            validator: (txt) {},
                            onChanged: (txt) {},
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Option c',
                            )),
                      ),
                      SizedBox(
                        width: size.width / 10,
                      ),
                      Expanded(
                        child: TextFormField(
                            validator: (txt) {},
                            onChanged: (txt) {},
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8))),
                              labelText: 'Option d',
                            )),
                      )
                    ],
                  ),
                  //DropdownButton(items: items, onChanged: onChanged)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
