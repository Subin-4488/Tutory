import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: MediaQuery.of(context).size.width/1.55, 
        child: Container(
          child: Column(
            children: [
              Container(),
              TextButton(onPressed: (){}, child: const Text('Leaderboard')),
            ],
          ),
          color: Colors.purple,
        ),
      ),
    );

  }
}
