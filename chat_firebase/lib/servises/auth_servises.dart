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
    if (user != null) {
      _sessionDataProvider.setAccountId(user.uid.toString());
      return UserApp(uid: user.uid);
    } else {
      _sessionDataProvider.setAccountId(null); // Clear accountId
      return null;
    }
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

      //return _userFromFirebaseUser(user);
      return user;// Возвращаем User после успешного входа
    } catch (e) {
      print('ошибка при анонимном входе - ${e.toString()}');
      return null;
    }
  }

  ///---------------------выйти----------------------------------------
 Future signOut() async {
    try {
      await _auth.signOut();
      _sessionDataProvider.setAccountId(null); // Clear accountId on sign out
    } catch (error) {
      print('error.toString()!!!!!!!!!!!!!!!!!!! ${error.toString()}');
      throw error; // Rethrow the error for handling in UI if necessary
    }
  }
}
