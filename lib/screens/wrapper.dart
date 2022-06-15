import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutory/models/usermodel.dart';
import 'package:tutory/screens/authenticate/authenticate.dart';
import 'package:tutory/screens/home/admin/adminhome.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel?>(context);

    if (_user != null)
      return AdminHome();
    else
      return Authenticate();
  }
}
