import 'package:chat_firebase/presentation/auth_screen/provider/maim_screen_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../data/models/user/user_app.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../servises/data_base_messages.dart';
import 'personaliti_chat/personaliti_chat.dart';
import '../../../data/models/chat/chat_model.dart';
import 'package:intl/intl.dart';

class UserItem extends StatelessWidget {
  const UserItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final users = Provider.of<List<UserAppData>>(context);
    final ChatService chatService = ChatService();

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

        // Создаем chatId на основе текущего пользователя и uid пользователя из списка
        final chatId = currentUserId.compareTo(user.uid) > 0
            ? '${user.uid}$currentUserId'
            : '$currentUserId${user.uid}';

        return StreamBuilder<ChatMessage?>(
          stream: chatService.getLastMessage(chatId),
          builder: (context, snapshot) {
            String lastMessageText = 'Нет сообщений';
            String senderText = '';
            TextStyle messageTextStyle = const TextStyle(
              color: Color(0xFF5E7A90),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            );
            String lastMessageTime = '';

            if (snapshot.connectionState == ConnectionState.waiting) {
              lastMessageText = 'Загрузка...';
            } else if (snapshot.hasError) {
              lastMessageText = 'Ошибка загрузки сообщения';
            } else if (snapshot.hasData && snapshot.data != null) {
              final ChatMessage lastMessage = snapshot.data!;
              lastMessageText = lastMessage.text;

              // Определяем отправителя последнего сообщения
              if (lastMessage.senderId == currentUserId) {
                senderText = 'Вы: ';
              } else {
                messageTextStyle = const TextStyle(
                  color: Color(0xFF1FDB5F),
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                );
              }

              // Форматируем время последнего сообщения
              final now = DateTime.now();
              final messageTime = lastMessage.timestamp.toDate();
              final difference = now.difference(messageTime);

              if (difference.inMinutes < 60) {
                lastMessageTime = '${difference.inMinutes} минут назад';
              } else if (difference.inHours < 24 && now.day == messageTime.day) {
                lastMessageTime = DateFormat('HH:mm').format(messageTime);
              } else if (difference.inHours < 48 && now.day - messageTime.day == 1) {
                lastMessageTime = 'Вчера';
              } else {
                lastMessageTime = DateFormat('dd.MM.yy').format(messageTime);
              }
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
                        Row(
                          children: [
                            Text(
                              senderText,
                              style: const TextStyle(
                                color: Color(0xFF2B333E),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                lastMessageText,
                                style: messageTextStyle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: Text(
                      lastMessageTime,
                      style: const TextStyle(
                        color: Color(0xFF5E7A90),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(user: user),
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
      },
    );
  }
}
