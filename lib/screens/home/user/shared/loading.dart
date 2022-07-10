// ignore_for_file: unnecessary_cast, use_build_context_synchronously, avoid_print, unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';

import '../Models/question.dart';

List<Question> questions=[];
class LoadingShared extends StatelessWidget {
  const LoadingShared({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  Future<List<Question>>  getQuestions(int category, String difficulty) async {
  String url = "https://opentdb.com/api.php?amount=11&category=$category&difficulty=$difficulty&type=multiple";

  Response response=await(get(Uri.parse(url)));
  List<Map<String, dynamic>> question = List<Map<String,dynamic>>.from(json.decode(response.body)["results"]);
  return Question.fromData(question);
}

  Future<void> startQuiz(Map data) async {
    try {
      List<Question> questions =  await getQuestions(data['id'],data['level']);
      Navigator.popAndPushNamed(context,'/quiz',arguments:questions as List<Question>);
    } catch (e) {
     print(e);
  }
}
  List<Question>  questions=[];
   final Map data = ModalRoute.of(context)?.settings.arguments as Map;
  startQuiz(data);
    return Container(
      color: Colors.white,
      child: SpinKitCubeGrid(
        color: Colors.purple,
      ),
    );
  }
}

class Loader {

  

}