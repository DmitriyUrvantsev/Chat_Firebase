import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../personaliti_chat/personaliti_chat.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserAppData>>(context);
    //final String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final read = context.read<MainScreenProvider>();
        final user = users[index];
        final nik = '${user.name?[0]}${user.surName?[0]}';
        final color = read.getColorForLetter(user.name?[0] ?? 'a');

        final String currentUserId = FirebaseAuth.instance.currentUser!.uid;
        if (user.uid == currentUserId) {
          // Пропустить текущего пользователя
          return const SizedBox.shrink();
        }

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const Divider(height: 1, color: Color(0xFFE0E0E0)),
              ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 8),
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
                          color: color,
                          borderRadius: BorderRadius.circular(34),
                        ),
                        child: Center(
                          child: Text(
                            nik,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${user.name} ${user.surName}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                     const Row(
                      children: [
                        Text(
                          'Вы:', // Placeholder text, replace with actual logic
                          style: TextStyle(
                            color: Color(0xFF2B333E),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 4),
                        Text(
                          
                          'Уже сделал?', // Placeholder text, replace with actual logic
                          style: TextStyle(
                            color: Color(0xFF5E7A90),
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                trailing: const Text(
                  'Вчера', // Placeholder text, replace with actual logic
                  style: TextStyle(
                    color: Color(0xFF5E7A90),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(user: user
                          // receiverId: user.uid,
                          // receiverName: '${user.name} ${user.surName}',
                          ),
                    ),
                  );
                },
              ),
              if (index == users.length - 1)
                const Divider(height: 1, color: Color(0xFFE0E0E0)),
            ],
          ),
        );
      },
    );
  }
}
