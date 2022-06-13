import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tutory/screens/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:tutory/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.lightGreen, fontFamily: 'Nunito'),
      home: StreamProvider.value(
        child: Wrapper(),
        value: AuthService().stream, 
        initialData: null
        ),
      debugShowCheckedModeBanner: false,

    );
  }
}
