import 'package:cloud_firestore/cloud_firestore.dart';
import '../data/models/chat/chat_model.dart';

class ChatService2 {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Метод для создания чата
  Future<String> createChat(String userId1, String userId2) async {
    // Генерация chatId на основе userId1 и userId2
    final chatId = userId1.compareTo(userId2) > 0
        ? '$userId2$userId1'
        : '$userId1$userId2';
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

  // Метод для отправки сообщения
  Future<void> sendMessage(String chatId, ChatMessage message) async {
    final messagesCollection =
        _db.collection('chats').doc(chatId).collection('messages');
    // Добавление нового сообщения в коллекцию
    await messagesCollection.add(message.toMap());

    // Обновление документа чата с последним сообщением и временем обновления
    await _db.collection('chats').doc(chatId).update({
      'lastMessage': message.toMap(),
      'updatedAt': message.timestamp,
    });
  }

  // Метод для получения потока сообщений
  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp') // Упорядочивание сообщений по времени
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromMap(doc.data()))
            .toList());
  }
}




class ChatService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Метод для создания чата
  Future<String> createChat(String userId1, String userId2) async {
    // Генерация chatId на основе userId1 и userId2
    final chatId = userId1.compareTo(userId2) > 0
        ? '$userId2$userId1'
        : '$userId1$userId2';
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

  // Метод для отправки сообщения
  Future<void> sendMessage(String chatId, ChatMessage message) async {
    final messagesCollection =
        _db.collection('chats').doc(chatId).collection('messages');
    // Добавление нового сообщения в коллекцию
    await messagesCollection.add(message.toMap());

    // Обновление документа чата с последним сообщением и временем обновления
    await _db.collection('chats').doc(chatId).update({
      'lastMessage': message.toMap(),
      'updatedAt': message.timestamp,
    });
  }

  // Метод для получения потока сообщений
  Stream<List<ChatMessage>> getMessages(String chatId) {
    return _db
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp') // Упорядочивание сообщений по времени
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromMap(doc.data()))
            .toList());
  }
}
