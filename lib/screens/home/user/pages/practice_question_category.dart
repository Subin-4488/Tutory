// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutory/screens/home/user/Models/category.dart';
class Practice_Question_Category extends StatelessWidget {
  const Practice_Question_Category({Key? key}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Select the category",style: TextStyle(
            fontSize: 18,color: Colors.white),),
            centerTitle: true,
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        
      ),
    body: ListView.builder(itemCount:categories.length,
        itemBuilder: (context,length){
          return Card(
            elevation: 2.5,
            child: ListTile(
              onTap: (){
                Navigator.pushNamed(context, '/level',arguments: {'id':categories[length].id});
              },
             title: Text(categories[length].name,style: const TextStyle(fontSize: 15, color: Colors.black),),
            leading: CircleAvatar(backgroundColor: Colors.deepPurple,
              child: FaIcon(categories[length].icon,color: Colors.white,),
            ),
            tileColor: const Color.fromARGB(223, 255, 255, 255),
          ),
          );

        }
      ),
    );
  }
  
  
}