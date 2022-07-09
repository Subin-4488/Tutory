// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutory/services/auth.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/shared/textformfielddecorator.dart';

class SignIn extends StatefulWidget {
  static int selected=0;

  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _key = GlobalKey<FormState>();
  double elev = 1.0;
  String email = '';
  String password = '';
  bool load = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return load
        ? LoadingShared()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: size.height / 10, left: size.height / 20),
                  alignment: Alignment.topLeft,
                  child: const Text(
                    'TUTORY',
                    style: TextStyle(
                      fontFamily: 'Splash',
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      height: size.height / 1.8,
                      padding: const EdgeInsets.only(
                          left: 18.0, right: 18.0, bottom: 18.0),
                      child: Form(
                        key: _key,
                        child: Column(
                          children: [
                            const Expanded(
                              child: SizedBox(),
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 45,
                            ),
                            TextFormField(
                              style: const TextStyle(fontSize: 16),
                              validator: (val) {
                                if (val!.length >= 6 &&
                                    (val.endsWith("@gmail.com") ||
                                        val.endsWith("@yahoo.com"))) {
                                  return null;
                                } else {
                                  return 'Enter valid email';
                                }
                              },
                              decoration: TextFormFieldDecorator()
                                  .getDecorator('Email'),
                              onChanged: (txt) {
                                email = txt;
                              },
                            ),
                            SizedBox(
                              height: size.height / 45,
                            ),
                            TextFormField(
                              obscureText: true,
                              style: const TextStyle(fontSize: 16),
                              onTap: () {
                                elev = 2.0;
                              },
                              onChanged: (txt) {
                                password = txt;
                              },
                              validator: (val) {
                                if (val!.length >= 8) {
                                  return null;
                                } else {
                                  return 'Password must be atleast 8 characters long';
                                }
                              },
                              decoration: TextFormFieldDecorator()
                                  .getDecorator('password'),
                            ),
                            SizedBox(
                              height: size.height / 45,
                            ),
                            FlutterToggleTab(
                              unSelectedBackgroundColors: [Colors.black],
                              selectedBackgroundColors: [Colors.deepPurple],
                              width: size.width / 8,
                              borderRadius: 15,
                              selectedIndex: SignIn.selected,
                              selectedTextStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600),
                              unSelectedTextStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400),
                              labels: ['Admin', 'User'],
                              //icons: const [Icons.arrow_left, Icons.arrow_right],
                              selectedLabelIndex: (index) {
                                setState(() {
                                  SignIn.selected = index;
                                });
                              },
                              marginSelected: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 4),
                            ),
                            SizedBox(
                              height: size.height / 45,
                            ),
                            Container(
                              width: size.width,
                              child: ElevatedButton(
                                  style: ButtonStyle(
                                    elevation: MaterialStateProperty.all(2.0),
                                  ),
                                  onPressed: () async {
                                    if (_key.currentState!.validate()) {
                                      setState(() {
                                        load = true;
                                      });
                                      final user;
                                      if (SignIn.selected == 0) {
                                        //admin
                                        user = await AuthService()
                                            .signInAdmin(email, password);
                                      } else {
                                        //user
                                        user = await AuthService()
                                            .signInEmailPass(email, password);
                                      }

                                      if (user != null) {
                                        Navigator.pop(context);
                                        setState(() {
                                          load = false;
                                        });
                                      } else {
                                        setState(() {
                                          load = false;
                                          Fluttertoast.showToast(
                                              gravity: ToastGravity.CENTER,
                                              fontSize: 18,
                                              textColor: Colors.red,
                                              backgroundColor:
                                                  Colors.transparent,
                                              msg: 'Invalid credentials');
                                        });
                                      }
                                    }
                                  },
                                  child: const Text(
                                    'SIGN IN',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  )),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Register',
                                    style: TextStyle(fontSize: 16)))
                          ],
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}
