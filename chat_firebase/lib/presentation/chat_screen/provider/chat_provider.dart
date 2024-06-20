
import 'package:flutter/material.dart';
import 'package:chat_firebase/servises/auth_servises.dart';


class ChatScreenProvider extends ChangeNotifier {
//---------------- Авторизация на сервере ------------------------------------
  Future singIn() async {
    AuthService().signOut();
    
  }
}
