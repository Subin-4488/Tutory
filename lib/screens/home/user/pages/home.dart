// ignore_for_file: prefer_const_constructors, duplicate_ignore, unused_field

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'home_container.dart';
import 'study.dart';
import 'practice.dart';
import 'competition.dart';
import 'profile.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  int _selecteditem=0;
  PageController pageController=PageController();
  
  final _key = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[700],
      appBar: AppBar(
        title: Text("TUTORY", textAlign: TextAlign.right,style: TextStyle(fontSize: 25,color: Colors.white,fontWeight: FontWeight.bold,letterSpacing:2,),),
            centerTitle: true,
        backgroundColor: Colors.deepPurple[700],
        elevation: 0,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.logout))
        ],
        
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 40, 38, 38),
        child: Padding(
          padding: const EdgeInsets.only(top:150),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Center(
                  child: Container(
                    height:50,
                    width:double.infinity,
                    child:ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 38, 38),),
                      elevation: MaterialStateProperty.all(0)),
                      onPressed: () {changeTab(0);},
                      child: TextButton.icon(onPressed: (){changeTab(0);}, icon: FaIcon(FontAwesomeIcons.house,color: Colors.white,size: 16,), label: Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Text("Home",style: TextStyle(fontSize: 15,color: Colors.white,),),
                      )),
                    ),
                  ),
                ),
                  SizedBox(height: 5,),
                  Center(
                  child: Container(
                    height:50,
                    width:double.infinity,
                    child:ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 38, 38),),
                      elevation: MaterialStateProperty.all(0)),
                      onPressed: () {changeTab(1);},
                      child: TextButton.icon(onPressed: (){changeTab(1);}, icon: FaIcon(FontAwesomeIcons.book,color: Colors.white,size: 16,), label: Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Text("Materials",style: TextStyle(fontSize: 15,color: Colors.white,),),
                      )),
                    ),
                  ),
                ),
                  SizedBox(height: 5,),
                  Center(
                  child: Container(
                    height:50,
                    width:double.infinity,
                    child:ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 38, 38),),
                      elevation: MaterialStateProperty.all(0)),
                      onPressed: () {changeTab(2);},
                      child: TextButton.icon(onPressed: (){changeTab(2);}, icon: Icon(Icons.track_changes,color: Colors.white,size: 16,), label: Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Text("Practice",style: TextStyle(fontSize: 15,color: Colors.white,),),
                      )),
                    ),
                  ),
                ),
                  SizedBox(height: 5,),
                  Center(
                  child: Container(
                    height:50,
                    width:double.infinity,
                    child:ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 38, 38),),
                      elevation: MaterialStateProperty.all(0)),
                      onPressed: () {changeTab(3);},
                      child: TextButton.icon(onPressed: (){changeTab(3);}, icon: FaIcon(FontAwesomeIcons.globe,color: Colors.white,size: 16,), label: Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Text("Compete",style: TextStyle(fontSize: 15,color: Colors.white,),),
                      )),
                    ),
                  ),
                ),
                  SizedBox(height: 5,),
                  Center(
                  child: Container(
                    height:50,
                    width:double.infinity,
                    child:ElevatedButton(
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 40, 38, 38),),
                      elevation: MaterialStateProperty.all(0)),
                      onPressed: () {changeTab(4);},
                      child: TextButton.icon(onPressed: (){changeTab(4);}, icon: FaIcon(FontAwesomeIcons.person,color: Colors.white,size: 16,), label: Padding(
                        padding: const EdgeInsets.only(left:20),
                        child: Text("Profile",style: TextStyle(fontSize: 15,color: Colors.white,),),
                      )),
                    ),
                  ),
                ),
                  SizedBox(height: 200,),
                  Center(
                    child: Text("TUTORY",textAlign: TextAlign.end,style: TextStyle(fontSize: 18,fontWeight:FontWeight.bold,color:Colors.white),),
                  ),
              ],
          ),
        ),
      ),
      body: PageView(
      controller: pageController,
      children: const [
        Home_Container(),
        Study(),
        Practice(),
        Competition(),
        Profile(),
      ],
    ),
    );
  }
  void changeTab(int index) {
    setState(() {
      _selecteditem=index;
      
    });
    pageController.jumpToPage(_selecteditem);
  }
}