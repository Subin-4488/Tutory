import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tutory/screens/authenticate/signin.dart';
import 'package:tutory/services/auth.dart';
import 'package:tutory/shared/loading.dart';
import 'package:tutory/shared/textformfielddecorator.dart';
import 'package:tutory/shared/textstyle.dart';

class SignIn extends StatefulWidget {
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
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return load
        ? LoadingShared()
        : Scaffold(
            body: Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/back.png'),
                        fit: BoxFit.fill),
                  ),
                ),
                Column(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      height: size.height / 1.8,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
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
                                'SIGN IN',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(
                              height: size.height / 45,
                            ),
                            TextFormField(
                              style: TextStyleShared().getTextStyle(16),
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
                              style: TextStyleShared().getTextStyle(16),
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
                              unSelectedBackgroundColors: [Colors.white],
                              selectedBackgroundColors: [Colors.blue],
                              width: size.width / 8,
                              borderRadius: 15,
                              selectedIndex: selected,
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
                                  selected = index;
                                });
                              },
                              marginSelected: EdgeInsets.symmetric(
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
                                      final user = await AuthService()
                                          .signInEmailPass(email, password);
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
                                  child: Text(
                                    'SIGN IN',
                                    style: TextStyleShared()
                                        .getTextStyle(16)
                                        .copyWith(color: Colors.white),
                                  )),
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Register',
                                  style: TextStyleShared().getTextStyle(16),
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
