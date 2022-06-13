import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutory/models/usermodel.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;

  //usermodel from firebase user

  UserModel? _getUserModel(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  //stream from firebase
  Stream<UserModel?> get stream {
    return _auth.authStateChanges().map((event) {
      return _getUserModel(event);
    });
  }

  //sign in emai pass

  //sign in phone

  //signout

}
