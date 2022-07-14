import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutory/models/usermodel.dart';
import 'package:tutory/screens/authenticate/authenticate.dart';
import 'package:tutory/screens/authenticate/register.dart';
import 'package:tutory/screens/authenticate/signin.dart';
import 'package:tutory/screens/home/admin/adminhome.dart';
import 'package:tutory/screens/home/user/userhome.dart';

class Wrapper extends StatefulWidget {
  static int selected = 0;
  static int reg = 0;

  const Wrapper({Key? key}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('Register: ' + Wrapper.reg.toString());
    print('Selected: ' + Wrapper.selected.toString());
  }

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<UserModel?>(context);

    if (_user != null) {
      setState(() {
        Wrapper.reg;
        Wrapper.selected;
      });
      saveUserState();

      if (Wrapper.reg == 1) {
        return UserHome();
      } else if (Wrapper.selected == 1) {
        return UserHome();
      } else {
        return AdminHome();
      }
    } else
      return Authenticate();
  }

  Future<void> saveUserState() async {
    SharedPreferences _preferences = await SharedPreferences.getInstance();
    _preferences.setInt('register', Wrapper.reg);
    _preferences.setInt('selected', Wrapper.selected);
  }
}
