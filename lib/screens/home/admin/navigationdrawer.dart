import 'package:flutter/material.dart';

class NavigationDrawer extends StatefulWidget {
  static int select = 0;

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Drawer(
      backgroundColor: Colors.transparent,
      child: Material(
        color: const Color.fromARGB(255, 40, 38, 38),
        child: Column(
          children: [
            const Expanded(child: SizedBox()),
            SizedBox(
              height: size.height / 8,
            ),
            buildItem('Leaderboard', Icons.leaderboard, 0),
            SizedBox(
              height: size.height / 70,
            ),
            buildItem('Material', Icons.book, 1),
            SizedBox(
              height: size.height / 70,
            ),
            buildItem('User Analytics', Icons.person, 2),
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
    );
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
            NavigationDrawer.select = idx;
          });

          Navigator.of(context).pop();
          if (idx == 0) {
            //leaderboard
          } else if (idx == 1) {
            //material

          } else if (idx == 2) {
            //user analytics

          } else {
            //settings

          }
        });
  }
}
