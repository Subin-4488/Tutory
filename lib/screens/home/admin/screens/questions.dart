import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tutory/models/question.dart';
import 'package:tutory/screens/home/admin/screens/addquestions.dart';
import 'package:tutory/services/database.dart';
import 'package:tutory/shared/loading.dart';

class Questions extends StatefulWidget {
  final String topic;
  final int year;

  const Questions({Key? key, required this.topic, required this.year})
      : super(key: key);

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title:  Text('${widget.topic} ${widget.year}'),
      ),
      body: Material(
        child: Column(children: [
          Expanded(
            child: Container(
                //height: size.height/1.5,
                alignment: Alignment.center,
                child: FutureBuilder(
                    future: Database(uid: '')
                        .getPrevQuestions(widget.topic, widget.year),
                    builder: ((context, AsyncSnapshot<List<Question>> snapshot) {
                      if (snapshot.connectionState==ConnectionState.done) {
                        List<Question>? list = snapshot.data;
                        if (snapshot.hasData && list!.length>0) {
                          return ListView.builder(
                              itemBuilder: ((context, index) {
                                return Card(
                                  child: Material(
                                    child: ListTile(
                                      contentPadding: const EdgeInsets.all(20),
                                      onTap: (() {
                                        //modify question (update and delete)
                                      }),
                                      title: Text(list[index].question,style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),),
                                      subtitle: Text(list[index].year.toString(),style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold
                                      ),),
                                    ),
                                  ),
                                );
                              }),
                              itemCount: list.length);
                        } else {
                          return const Center(
                            child: Text('No record found'),
                          );
                        }
                      }
                      return const Center(
                            child: LoadingShared(),
                          );
                    }))),
          ),
        ]),
      ),
      floatingActionButton: FloatingActionButton(
                  backgroundColor: Colors.blue,
                  child: Icon(Icons.add),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: ((context) {
                      return AddQuestions(topic: widget.topic,year: widget.year,);
                    })));
                  }),
    );
  }
}
