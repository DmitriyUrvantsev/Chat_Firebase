import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user/user_app.dart';
import '../../../servises/auth_servises.dart';
import '../../../servises/data_base.dart';
import '../../auth_screen/provider/maim_screen_provider.dart';
import 'user_item.dart';

class ChatScreenWidget extends StatelessWidget {
  const ChatScreenWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthService();

    final read = context.read<MainScreenProvider>();
    return StreamProvider<List<UserAppData>>.value(
      value: DatabaseService(uid: read.uid ?? '').allUsers,
      initialData: [],
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Center(child: Text('Чаты')),
          backgroundColor: Colors.grey.shade400,
          elevation: 0.0,
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton.icon(
               
                icon: const Icon(
                  Icons.exit_to_app,
                  color: Colors.white,
                ),
                label: const Text(''),
                onPressed: () async {
                  await auth.signOut();
                },
              ),
            ),
          ],
        ),
        body: const UserItem(),
      ),
    );
  }
}

