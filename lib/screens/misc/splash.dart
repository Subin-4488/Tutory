import 'package:animated_text_kit/animated_text_kit.dart';
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
        color: Color.fromARGB(255, 255, 255, 255),
        alignment: Alignment.center,
        child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
          WavyAnimatedText(
            'Tutory',
            speed: const Duration(milliseconds: 300),
            textStyle: 
          const TextStyle(
            fontFamily: 'Splash',
            fontSize: 55
          )
          )
        ]),
      ),
    );
  }
}