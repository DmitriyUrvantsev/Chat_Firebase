import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/chat/chat_model.dart';


class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<String> createChat(String userId1, String userId2) async {
    final chatId = userId1.compareTo(userId2) > 0 ? '$userId2$userId1' : '$userId1$userId2';
    final chatDoc = _db.collection('chats').doc(chatId);

    final chatSnapshot = await chatDoc.get();
    if (!chatSnapshot.exists) {
      await chatDoc.set({
        'participants': [userId1, userId2],
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });
    }

    return chatId;
  }

  Future<void> sendMessage(String chatId, ChatMessage message) async {
    final messagesCollection = _db.collection('chats').doc(chatId).collection('messages');
    await messagesCollection.add(message.toMap());

    await _db.collection('chats').doc(chatId).update({
      'lastMessage': message.toMap(),
      'updatedAt': message.timestamp,
    });
  }

  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _db.collection('chats').doc(chatId).collection('messages')
      .orderBy('timestamp')
      .snapshots()
      .map((snapshot) => snapshot.docs
        .map((doc) => ChatMessage.fromMap(doc.data()))
        .toList());
  }
}
