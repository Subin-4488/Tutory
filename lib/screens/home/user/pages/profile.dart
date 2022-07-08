import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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