import 'package:flutter/material.dart';
import 'package:chat_firebase/data/models/user/user_app.dart';
import 'package:chat_firebase/presentation/auth_screen/main_screen.dart';
import 'package:provider/provider.dart';
import 'presentation/auth_screen/account_screens/account_screen.dart';
import 'presentation/auth_screen/provider/maim_screen_provider.dart';
import 'presentation/chat_list/screens/chat_list_screen.dart';


class SelectorLoading extends StatefulWidget {
  const SelectorLoading({super.key});

  @override
  State<SelectorLoading> createState() => _SelectorLoadingState();
}

class _SelectorLoadingState extends State<SelectorLoading> {
  @override
  void initState() {
    super.initState();
    final read = context.read<MainScreenProvider>();
    read.isChekAuth();
  }

  @override //!надо получать из FlutterSecureStorage() - если там есть/
  Widget build(BuildContext context) {
    final read = context.read<MainScreenProvider>();
    final user = Provider.of<UserApp?>(context);
    print('SelectorLoading uid - ${user?.uid} ');

    final isAuth = read.isAuth;
    print('SelectorLoading - isAuth: $isAuth');
    //!пока задублированна проверка(можно по  isAuth проверять а можно по user?.uid)
    //в зависимости от того, получен ли ID или нет, попадаем либо на авторизацию
    //либо на главный экран
    if (user?.uid == null) {
      return const K3AccounrScreenWidget();//uid: user?.uid??'');
    } else {
      return const ChatScreenWidget();
      //K2MainScreenWidget(); //uid: user!.uid);
    }
  }
}
