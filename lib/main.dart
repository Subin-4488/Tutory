// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tutory/screens/misc/splash.dart';
import 'package:tutory/screens/misc/tutorytheme.dart';
import 'package:tutory/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:tutory/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
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
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    navigate();
  }

  void navigate() async {
    try {
      SharedPreferences _preference = await SharedPreferences.getInstance();
      late var r = _preference.getInt('register');
      late var s = _preference.getInt('selected');
      r != null ? Wrapper.reg = r : Wrapper.reg = 0;
      s != null ? Wrapper.selected = s : Wrapper.selected = 0;
    } catch (e) {
      print(e.toString());
    }

    await Future.delayed(Duration(seconds: 2), () {
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
              value: AuthService().stream, initialData: null, child: Wrapper()),
      debugShowCheckedModeBanner: false,
    );
  }
}
