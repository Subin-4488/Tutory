import 'package:flutter/material.dart';

class Study extends StatefulWidget {
  const Study({Key? key}) : super(key: key);

  @override
  State<Study> createState() => _StudyState();
}

class _StudyState extends State<Study> {
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