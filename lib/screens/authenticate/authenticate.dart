import 'package:flutter/material.dart';
import 'package:tutory/screens/authenticate/register.dart';
import 'package:tutory/screens/authenticate/signin.dart';

class Authenticate extends StatefulWidget {
  Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  @override
  Widget build(BuildContext context) {
    return Register();
  }
}
