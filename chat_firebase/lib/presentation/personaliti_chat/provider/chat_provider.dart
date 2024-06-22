import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

// chat_provider.dart
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/models/chat/chat_model.dart';
import '../../../servises/data_base_messages.dart';

// class ChatProvider2 extends ChangeNotifier {
//   final ChatService _chatService = ChatService();
//   String? _currentChatId;
//   List<ChatMessage> _messages = [];

//   // Геттеры для текущего чата и сообщений
//   String? get currentChatId => _currentChatId;
//   List<ChatMessage> get messages => _messages;

//   // Метод для создания чата
//   Future<void> createChat(String userId1, String userId2) async {
//     _currentChatId = await _chatService.createChat(userId1, userId2);
//     notifyListeners();
//   }

//   // Метод для получения потока сообщений
//   Stream<List<ChatMessage>> getMessages() {
//     if (_currentChatId != null) {
//       return _chatService.getMessages(_currentChatId!).map((messages) {
//         updateMessages(messages);
//         return messages;
//       });
//     }
//     return const Stream.empty();
//   }

//   // Метод для отправки сообщения
//   Future<void> sendMessage(ChatMessage message) async {
//     if (_currentChatId != null) {
//       await _chatService.sendMessage(_currentChatId!, message);
//     }
//   }

//   // Метод для обновления списка сообщений
//   void updateMessages(List<ChatMessage> newMessages) {
//     _messages = newMessages;
//     notifyListeners();
//   }

//   /// Навигация
//   ///
//   void back() {
//     NavigatorService.goBack();
//   }
// }

class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  String? _currentChatId;
  List<ChatMessage> _messages = [];
  Timestamp? lastTimeChangeDate;

  // Геттеры для текущего чата и сообщений
  String? get currentChatId => _currentChatId;
  List<ChatMessage> get messages => _messages;

  // Метод для создания чата
  Future<void> createChat(String userId1, String userId2) async {
    _currentChatId = await _chatService.createChat(userId1, userId2);
    notifyListeners();
  }

  // Метод для получения потока сообщений
  Stream<List<ChatMessage>> getMessages() {
    if (_currentChatId != null) {
      return _chatService.getMessages(_currentChatId!).map((messages) {
        updateMessages(messages);
        return messages;
      });
    }
    return const Stream.empty();
  }

  // Метод для отправки сообщения
  Future<void> sendMessage(ChatMessage message) async {
    if (_currentChatId != null) {
      final currentTime = message.timestamp;
      Timestamp? timeChangeDate;
      print('lastTimeChangeDate $lastTimeChangeDate');
      // Если прошло более одной минуты с момента последнего сообщения, обновляем timeChangeDate
      if (lastTimeChangeDate == null ||
          currentTime
                  .toDate()
                  .difference(lastTimeChangeDate!.toDate())
                  .inMinutes >
              0) {
        timeChangeDate = currentTime;
        lastTimeChangeDate = currentTime;
      }

      final updatedMessage = ChatMessage(
        senderId: message.senderId,
        text: message.text,
        timestamp: message.timestamp,
        timeChangeDate: timeChangeDate, // Используем timeChangeDate
      );

      await _chatService.sendMessage(_currentChatId!, updatedMessage);
    }
  }

  // Метод для обновления списка сообщений
  void updateMessages(List<ChatMessage> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }

  // Навигация
  void back() {
    NavigatorService.goBack();
  }
}
