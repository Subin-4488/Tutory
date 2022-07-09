import 'package:flutter/material.dart';
import 'package:tutory/screens/authenticate/signin.dart';
import 'package:tutory/screens/home/user/pages/Quiz.dart';
import 'package:tutory/screens/home/user/pages/competition.dart';
import 'package:tutory/screens/home/user/pages/evaluate.dart';
import 'package:tutory/screens/home/user/pages/home.dart';
import 'package:tutory/screens/home/user/pages/practice.dart';
import 'package:tutory/screens/home/user/pages/practice_hardness.dart';
import 'package:tutory/screens/home/user/pages/practice_question_category.dart';
import 'package:tutory/screens/home/user/pages/profile.dart';
import 'package:tutory/screens/home/user/pages/study.dart';
import 'package:tutory/screens/home/user/shared/loading.dart';
import 'package:tutory/screens/misc/tutorytheme.dart';

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: TutoryTheme.lightTheme,
      darkTheme: TutoryTheme.darkTheme,
      initialRoute: '/home',
      routes: {
        '/home': (context) => const Home(),
        '/study': (context) => const Study(),
        '/practice': (context) => const Practice(),
        '/competition': (context) => const Competition(),
        '/profile': (context) => const Profile(),
        '/level': (context) => const Level_scrn(),
        '/category': (context) => const Practice_Question_Category(),
        '/loading': (context) => const LoadingShared(),
        '/quiz': (context) => const Quiz(),
        '/validate': (context) => const Validate()
      },
    );
  }
}
