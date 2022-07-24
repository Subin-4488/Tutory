
// ignore_for_file: override_on_non_overriding_member, annotate_overrides, curly_braces_in_flow_control_structures, duplicate_ignore

import 'package:flutter/material.dart';
import '../pages/Quiz.dart';

import '../Models/question.dart';

class Validate extends StatefulWidget {
  const Validate({Key? key}) : super(key: key);

  @override
  State<Validate> createState() => _ValidateState();
}

class _ValidateState extends State<Validate> {
  @override
  int i=0;
  int r=0;
  dynamic green=Colors.green;
   dynamic red=Colors.red;
    dynamic c;
  Widget build(BuildContext context) {
    
    List<Question> questions = ModalRoute.of(context)?.settings.arguments as List<Question>;
    for(i=0;i<questions.length;i++)
    {
      // ignore: curly_braces_in_flow_control_structures
      if(questions[i].answer!=-1 && questions[i].answer!=-2)
        if(questions[i].correctAnswer==questions[i].incorrectAnswers[questions[i].answer])
          r++;
      
    }
    i=0;
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[700],
        title: Text("Your Result: $r/10",style: const TextStyle(fontSize: 20,color: Colors.white),),
      ),
      body: ListView(
          children: [
            for(int i=0;i<10;i++) Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10,),
                Container(color:Colors.white,padding:const EdgeInsets.all(8),child:Column(
                  children: [
                    Text(questions[i].question,style: const TextStyle(fontSize: 18)),
                    Row(children: [const Text("Your Answer: ",style: TextStyle(fontSize: 15),),
                                 questions[i].answer!=-1 && questions[i].answer!=-2 
                                 ? Expanded(child: Text(questions[i].incorrectAnswers[questions[i].answer],style : TextStyle(fontSize: 20,color: check(i)))) 
                                 : questions[i].answer==-1 ? const Text("Time Out",style: TextStyle(fontSize: 20,color: Colors.red),) 
                                 :const Text("Skipped",style: TextStyle(fontSize: 20,color: Colors.red),) ,],),
                    Row(children: [const Text("Correct Answer: ",style: TextStyle(fontSize: 15),),Expanded(child: Text(questions[i].correctAnswer,style: TextStyle(fontSize: 20,color: green),))],),
                    
                  ],  
                ),
                ),
              ],
            )
            ],),
      
        
    );
  }

  
  dynamic check(int i) {
    if(questions[i].correctAnswer==questions[i].incorrectAnswers[questions[i].answer])
      return green;
    else
      return red;  
    
  }
}