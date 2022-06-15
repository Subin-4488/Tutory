import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tutory/screens/home/admin/leaderboard.dart';
import 'package:tutory/screens/home/admin/materials.dart';
import 'package:tutory/screens/home/admin/navigationdrawer.dart';
import 'package:tutory/screens/home/admin/setttings.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height / 10,
      ),
      body: Body(),
      drawer: NavigationDrawer(),
    );
  }

  Widget Body() {
    setState(() {
      NavigationDrawer.select;
    });
    if (NavigationDrawer.select == 0)
      return Leaderboard();
    else if (NavigationDrawer.select == 1)
      return Materials();
    else
      return AdminSettings();
  }
}
