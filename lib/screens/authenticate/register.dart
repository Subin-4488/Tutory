import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutory/screens/authenticate/signin.dart';
import 'package:tutory/services/auth.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/shared/textformfielddecorator.dart';

class Register extends StatefulWidget {
  static int reg = 0;
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();
  double elev = 1.0;
  String email = '';
  String password = '';
  bool load = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    setState(() {
      Register.reg = 0;
    });

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
                      padding: const EdgeInsets.all(18.0),
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
                                'REGISTER',
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
                                      final user = await AuthService()
                                          .registerEmailPass(email, password);
                                      if (user != null) {
                                        Register.reg = 1;
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
                                              msg: 'Try again');
                                        });
                                      }
                                    }
                                  },
                                  child: const Text('Register',
                                      style: TextStyle(fontSize: 16))),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return SignIn();
                                  }));
                                },
                                child: const Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 16),
                                ))
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
