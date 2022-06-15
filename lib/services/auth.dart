import 'package:firebase_auth/firebase_auth.dart';
import 'package:tutory/models/usermodel.dart';
import 'package:tutory/screens/home/admin/adminhome.dart';
import 'package:tutory/services/database.dart';

class AuthService {
  final auth = FirebaseAuth.instance;

  //usermodel from firebase user

  UserModel? _getUserModel(User? user) {
    if (user != null) {
      return UserModel(uid: user.uid);
    } else {
      return null;
    }
  }

  //stream from firestore
  Stream<UserModel?> get stream {
    return auth.authStateChanges().map((event) {
      return _getUserModel(event);
    });
  }

  //register email pass

  Future<UserModel?> registerEmailPass(String em, String pass) async {
    try {
      UserCredential credential =
          await auth.createUserWithEmailAndPassword(email: em, password: pass);
      User? user = credential.user;
      if (user != null) {
        Database(uid: user.uid).insertUser(em, pass);
        return UserModel(uid: user.uid);
      } else {
        print('NULL');
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //sign in emai pass
  Future<UserModel?> signInEmailPass(String em, String pass) async {
    try {
      UserCredential credential =
          await auth.signInWithEmailAndPassword(email: em, password: pass);
      User? user = credential.user;
      if (user != null) {
        return UserModel(uid: user.uid);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  //sign in phone

  //signout
  Future signOut() async {
    await auth.signOut();
  }

  //admin

  //sign  in admin
  Future<UserModel?> signInAdmin(String em, String pass) async {
    try {
      bool check = await Database(uid: 'a').verifyAdmin(em, pass);
      if (check) {
        UserCredential credential =
            await auth.signInWithEmailAndPassword(email: em, password: pass);
        User? user = credential.user;
        if (user != null) return UserModel(uid: user.uid);
        return null;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }
}
