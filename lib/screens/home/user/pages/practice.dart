// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {

  int i=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: Container(
        decoration: BoxDecoration(
      border: Border.all( //color of border
        color: Colors.transparent,
          width: 60, //width of border
        ),
        color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      ),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Practice",style: TextStyle(fontSize: 18,color:Colors.black,fontWeight:FontWeight.w800,letterSpacing: 5),),
            
            TextButton.icon(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.bookMedical), label: Text("Previous Year Questions",style: TextStyle(fontSize: 15,color:Colors.black,),)),
            TextButton.icon(onPressed: (){Navigator.pushNamed(context, '/category');}, icon: FaIcon(FontAwesomeIcons.paperclip), label: Text("Practice Questions",style: TextStyle(fontSize: 15,color:Colors.black,)),),
          ],)
      ),
    );
  }
}