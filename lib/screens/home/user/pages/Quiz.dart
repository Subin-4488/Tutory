// ignore_for_file: file_names, sized_box_for_whitespace, avoid_print, prefer_interpolation_to_compose_strings

import 'dart:math';
import  'package:countdown_progress_indicator/countdown_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:tutory/screens/home/user/Models/question.dart';

List<Question> questions=[];
// ignore: camel_case_types


class Quiz extends StatefulWidget {
  
  const Quiz({Key? key}) : super(key: key);
  
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int i=0;
  int k=0;
  int r=0;
  List<int> answer=[0,0,0,0,0,0,0,0,0,0,0];
  @override
  Widget build(BuildContext context) {
    questions = ModalRoute.of(context)?.settings.arguments as List<Question>;
    setValue(i);
    return Scaffold(
      backgroundColor: Colors.blue[900],
      extendBodyBehindAppBar: true,
      appBar: AppBar(
       backgroundColor: Colors.transparent,
       elevation: 0,
       actions: [
        TextButton(onPressed: (){}, child: const Text("Skip",style:TextStyle(color:Colors.white))),
       ], 
    ),
    body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 75,left:30),
          child: Text("Question $r/10",style: const TextStyle(fontSize: 20,color:Colors.white),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(30,70,30,0),
          child: Container(
            height: 500,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color:Colors.white,
              
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return ListView(
                    children:[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(questions[i].question,style: const TextStyle(fontSize: 25,fontFamily: "Arial"),),
                              const SizedBox(height:50),
                              Container(decoration: BoxDecoration(
                              border: Border.all(
                               color: Colors.black, //color of border
                               width: 2, //width of border
                              ),borderRadius:BorderRadius.circular(15),),
                              width: double.infinity,
                              child:ElevatedButton(onPressed: (){
                                    
                                    questions[i].answer=0;
                                    i++;
                                  if(i>=10)
                                  {
                                    Navigator.popAndPushNamed(context, '/validate',arguments: questions);
                                    }
                                  else{
                                  setState(() {
                                    i;
                                  });
                                  }
                              },
                              style: ButtonStyle(
                                maximumSize:MaterialStateProperty.all(Size.infinite) ,
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                              ),
                               child: Text("1. "+questions[i].incorrectAnswers[0],
                               style: const TextStyle(fontSize: 18,color: Colors.black) ,))),
                              const SizedBox(height: 15,),
                              Container(decoration: BoxDecoration(
                              border: Border.all(
                               color: Colors.black, //color of border
                               width: 2, //width of border
                              ),borderRadius:BorderRadius.circular(15),),
                              width: double.infinity,
                              child:ElevatedButton(onPressed: (){
                                    
                                    questions[i].answer=1;
                                    i++;
                                  if(i>=10)
                                  {
                                    Navigator.popAndPushNamed(context, '/validate',arguments: questions);
                                    }
                                  else{
                                  setState(() {
                                    i;
                                  });
                                  }
                              },
                              style: ButtonStyle(
                                maximumSize:MaterialStateProperty.all(Size.infinite) ,
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                              ),
                               child: Text("2. "+questions[i].incorrectAnswers[1],
                               style: const TextStyle(fontSize: 18,color: Colors.black) ,))),
                              const SizedBox(height: 15,),
                              Container(decoration: BoxDecoration(
                              border: Border.all(
                               color: Colors.black, //color of border
                               width: 2, //width of border
                              ),borderRadius:BorderRadius.circular(15),),
                              width: double.infinity,
                              child:ElevatedButton(onPressed: (){
                                    
                                    questions[i].answer=2;
                                    i++;
                                  if(i>=10)
                                  {
                                    Navigator.popAndPushNamed(context, '/validate',arguments: questions);
                                    }
                                  else{
                                  setState(() {
                                    i;
                                  });
                                  }
                              },
                              style: ButtonStyle(
                                maximumSize:MaterialStateProperty.all(Size.infinite) ,
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                              ),
                               child: Text("3. "+questions[i].incorrectAnswers[2],
                               style: const TextStyle(fontSize: 18,color: Colors.black) ,))),
                              const SizedBox(height: 15,),
                              Container(decoration: BoxDecoration(
                              border: Border.all(
                               color: Colors.black, //color of border
                               width: 2, //width of border
                              ),borderRadius:BorderRadius.circular(15),),
                              width: double.infinity,
                              child:ElevatedButton(onPressed: (){
                                    
                                    questions[i].answer=3;
                                    i++;
                                  if(i>=10)
                                  {
                                    Navigator.popAndPushNamed(context, '/validate',arguments: questions);
                                    }
                                  else{
                                  setState(() {
                                    i;
                                  });
                                  }
                              },
                              style: ButtonStyle(
                                maximumSize:MaterialStateProperty.all(Size.infinite) ,
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor:MaterialStateProperty.all<Color>(Colors.white),
                              ),
                               child: Text("4. "+questions[i].incorrectAnswers[3],
                               style: const TextStyle(fontSize: 18,color: Colors.black) ,))),
                              const SizedBox(height: 15,),
                  
                      
                      ],
                    ),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
      ],
    ),
    
    
    );
  }

  void setValue(int j) {
    r++;
    if(j<10) {
      questions[j].incorrectAnswers.insert(Random().nextInt(4), questions[j].correctAnswer);
    }
  }
}