import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user/user_app.dart';
import '../../personaliti_chat/personaliti_chat.dart';

class UserItem extends StatelessWidget {
  const UserItem({super.key});

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserAppData>>(context);
    final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final nik = '${user.name?[0]}${user.surName?[0]}';

     

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: ListTile(
            leading: user.currentAvatar != null
                ? Container(
                    height: 50,
                    width: 50,
                    clipBehavior: Clip.hardEdge,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.network(
                      user.currentAvatar!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                  )
                : Container(
                    height: 50,
                    width: 50,
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child: Text(
                      nik,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
            title: Text('${user.name} ${user.surName}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    receiverId: user.uid,
                    receiverName: '${user.name} ${user.surName}',
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
