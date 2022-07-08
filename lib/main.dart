// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutory/screens/misc/splash.dart';
import 'package:tutory/screens/misc/tutorytheme.dart';
import 'package:tutory/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:tutory/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  bool splash = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    navigate();
  }

  void navigate() async {
    await Future.delayed(Duration(seconds: 5), () {
      setState(() {
        splash = false;
      });
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      AuthService().signOut();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.system,
      theme: TutoryTheme.lightTheme,
      darkTheme: TutoryTheme.darkTheme,
      home: splash
          ? Splash()
          : StreamProvider.value(
              value: AuthService().stream, initialData: null,
              child: Wrapper()),
      debugShowCheckedModeBanner: false,
    );
  }
}
