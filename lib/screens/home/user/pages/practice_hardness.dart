// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Level_scrn extends StatefulWidget {
  const Level_scrn({Key? key}) : super(key: key);

  @override
  State<Level_scrn> createState() => _Level_scrnState();
}

class _Level_scrnState extends State<Level_scrn> {
  late Map data;
  @override
  Widget build(BuildContext context) {
    final Map data = ModalRoute.of(context)?.settings.arguments as Map;
    print(data['id']);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select the level",textAlign: TextAlign.left,style: TextStyle(letterSpacing: 5,
            fontSize: 18,color: Colors.white),),
            centerTitle: true,
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        
      ),
    body:Column(  
      children: <Widget>[  
        Card(
          elevation: 2.5,
          child: ListTile(
            title: const Text("Easy",style: TextStyle(fontSize: 15, color: Colors.black),),
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child:FaIcon(FontAwesomeIcons.faceSmile,color: Colors.white,),
            ),
            onTap:(){
              Navigator.pushNamed(context, '/loading',arguments: {'id':data['id'],'level':'easy'});
            },
            tileColor: const Color.fromARGB(223, 255, 255, 255),
          ),
        ),
        Card(
          elevation: 2.5,
          child: ListTile(
            title: const Text("Medium",style: TextStyle(fontSize: 15,color: Colors.black)),
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child:FaIcon(FontAwesomeIcons.faceAngry,color: Colors.white,),
            ),
            onTap:(){
              Navigator.pushNamed(context, '/loading',arguments: {'id':data['id'],'level':'medium'});
            },
            tileColor: const Color.fromARGB(223, 255, 255, 255),
          ),
        ),
        Card(
          elevation: 2.5,
          child: ListTile(
            title: const Text("Hard",style: TextStyle(fontSize: 15,color: Colors.black)),
            leading: const CircleAvatar(
              backgroundColor: Colors.deepPurple,
              child:FaIcon(FontAwesomeIcons.faceGrimace,color: Colors.white,),
            ),
            onTap:(){
              Navigator.pushNamed(context, '/loading',arguments: {'id':data['id'],'level':'hard'});
            },
            tileColor: const Color.fromARGB(223, 255, 255, 255),
          ),
        ),  
      ],  
    ),
    );
  
  }
}