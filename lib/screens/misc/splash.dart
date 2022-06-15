import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('assets/images/back.png'))
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: const Text('TUTORY',style: TextStyle(fontSize: 50,
              fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}