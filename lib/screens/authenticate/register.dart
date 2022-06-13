import 'package:flutter/material.dart';
import 'package:tutory/shared/textformfielddecorator.dart';
import 'package:tutory/shared/textstyle.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.signpost_outlined),
        title: Text(
          'Register',
          style: TextStyleShared().getTextStyle(20),
        ),
        centerTitle: false,
      ),
      body: Container(
        padding: EdgeInsets.all(18.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              Expanded(
                child: SizedBox(),
              ),
              Card(
                elevation: 2.0,
                child: TextFormField(
                  style: TextStyleShared().getTextStyle(18), 
                  validator: (val) {
                    if (val!.length >= 6 &&
                        (val.endsWith("@gmail.com") ||
                            val.endsWith("@yahoo.com"))) {
                      return null;
                    } else {
                      return 'Enter valid email';
                    }
                  },
                  decoration: TextFormFieldDecorator().getDecorator('Email'),
                ),
              ),
              SizedBox(
                height: size.height / 85,
              ),
              Card(
                elevation: 2.0,
                child: TextFormField(
                  style: TextStyleShared().getTextStyle(18), 
                  validator: (val) {
                    if (val!.length >= 8) {
                      return null;
                    } else {
                      return 'Password must be atleast 8 characters long';
                    }
                  },
                  decoration: TextFormFieldDecorator().getDecorator('password'),
                ),
              ),
              SizedBox(
                height: size.height / 85,
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(2.0),
                  ),
                  onPressed: () {
                    if (_key.currentState!.validate()) {}
                  },
                  child: Text('Register',style: TextStyleShared().getTextStyle(16),)),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Register using phone',
                    style: TextStyleShared().getTextStyle(16),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
