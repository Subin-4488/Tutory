// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

class Home_Container extends StatefulWidget {
  const Home_Container({Key? key}) : super(key: key);

  @override
  State<Home_Container> createState() => _Home_ContainerState();
}

class _Home_ContainerState extends State<Home_Container> {
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
      )
      ),
    );
  }
}