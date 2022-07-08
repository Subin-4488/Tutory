import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutory/models/usermodel.dart';
import 'package:tutory/screens/authenticate/authenticate.dart';
import 'package:tutory/screens/authenticate/register.dart';
import 'package:tutory/screens/authenticate/signin.dart';
import 'package:tutory/screens/home/admin/adminhome.dart';
import 'package:tutory/screens/home/user/userhome.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel?>(context);

    if (_user != null) {
      setState(() {
        SignIn.selected;
        Register.reg;
      });

      print(SignIn.selected);
      print(Register.reg);

      if (Register.reg == 1) {
        return UserHome();
      } else if (SignIn.selected == 0) {
        return AdminHome();
      } else {
        return UserHome();
      }
    } else
      return Authenticate();
  }
}
