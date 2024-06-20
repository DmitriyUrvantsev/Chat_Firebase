import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_firebase/data/data_providers/session_data_provider.dart';
import 'package:chat_firebase/data/models/user/user_app.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _sessionDataProvider = SessionDataProvider();
  String? userName;
  //String? pinCode; //!======
  //static String verifyId = ""; //!===============

  UserApp? _userFromFirebaseUser(User? user) {
    //Future<UserApp?> _userFromFirebaseUser(User? user) async {
    _sessionDataProvider.setAccountId(user?.uid.toString());
    return user != null ? UserApp(uid: user.uid) : null;
  }

  // аутентификация, изменение пользовательского потока(залогинился или нет (user!=null))
  Stream<UserApp?>? get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }
///---------------------войти----------------------------------------

  // ---------войти анонимно------------
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch (e) {
      print('ошибка при анонимном входе - ${e.toString()}');
      return null;
    }
  }

  
  ///---------------------выйти----------------------------------------
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (error) {
      print('error.toString() ${error.toString()}');
      return null;
    }
  }
}
