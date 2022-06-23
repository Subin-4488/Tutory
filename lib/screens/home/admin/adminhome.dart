import 'package:flutter/material.dart';
import 'package:tutory/screens/home/admin/screens/leaderboard.dart';
import 'package:tutory/screens/home/admin/screens/materials.dart';
import 'package:tutory/screens/home/admin/screens/setttings.dart';
import 'package:tutory/screens/home/admin/screens/topic.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  final _key = GlobalKey<ScaffoldState>();

  int select = 0;
  @override
  Widget build(BuildContext context) {
    setState(() {
      select;
    });
    final size = MediaQuery.of(context).size;

    return Scaffold(
        key: _key,
        body: Container(
          alignment: Alignment.center,
          child: Stack(
            children: [
              Container(
                alignment: Alignment.center,
                child: select == 0
                    ? const Leaderboard()
                    : select == 1
                        ?  Materials()
                    :select==2?
                      Topic()
                    : AdminSettings(),
              ),
              Container(
                alignment: Alignment.topLeft, 
                child: IconButton(
                  color: Color.fromARGB(255, 238, 0, 0),
                  alignment: Alignment.topLeft,
                    padding:  EdgeInsets.only(top: size.height/11),  
                    onPressed: () {
                      _key.currentState!.openDrawer(); 
                    },
                    icon: const Icon(
                      Icons.arrow_right,
                      size: 45,
                    )),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: Colors.transparent,
          child: Material(
            color: const Color.fromARGB(255, 40, 38, 38),
            child: Column(
              children: [
                const Expanded(child: SizedBox()),
                SizedBox(
                  height: size.height / 8,
                ),
                buildItem('Remove User', Icons.leaderboard, 0),
                SizedBox(
                  height: size.height / 70,
                ),
                buildItem('Material', Icons.book, 1), 
                SizedBox(
                  height: size.height / 70,
                ),
                buildItem('Add Questions', Icons.person, 2), 
                SizedBox(
                  height: size.height / 70,
                ),
                buildItem('Settings', Icons.settings, 3),
                Container(
                  height: size.height / 2,
                  alignment: Alignment.bottomCenter,
                  child: const Padding(
                      padding: EdgeInsets.only(bottom: 50),
                      child: Text(
                        'TUTORY',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white),
                      )),
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildItem(String txt, IconData data, int idx) {
    return ListTile(
        contentPadding: const EdgeInsets.only(left: 25),
        leading: Icon(
          data,
          color: Colors.white,
        ),
        title: Text(
          txt,
          style: const TextStyle(color: Colors.white),
        ),
        onTap: () {
          setState(() {
            select = idx;
          });

          Navigator.of(context).pop();
          // if (idx == 0) {
          //   //leaderboard
          // } else if (idx == 1) {
          //   //material

          // } else if (idx == 2) {
          //   //user analytics

          // } else {
          //   //settings

          // }
        });
  }
}
