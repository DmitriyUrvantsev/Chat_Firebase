import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

// chat_provider.dart
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../../../data/models/chat/chat_model.dart';
import '../../../servises/data_base_messages.dart';
class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  String? _currentChatId;
  List<ChatMessage> _messages = [];

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

      if (_messages.isNotEmpty) {
        final lastMessage = _messages.last;
        // Сравнение по миллисекундам
        if (!isSameMinute(currentTime, lastMessage.timestamp)) {
          timeChangeDate = currentTime;
        }
      } else {
        timeChangeDate = currentTime;
      }

      final updatedMessage = ChatMessage(
        senderId: message.senderId,
        text: message.text,
        timestamp: currentTime,
        timeChangeDate: timeChangeDate,
      );

      await _chatService.sendMessage(_currentChatId!, updatedMessage);
    }
  }

  // Метод для обновления списка сообщений
  void updateMessages(List<ChatMessage> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }

  // Проверка, являются ли временные метки из одной и той же минуты
  bool isSameMinute(Timestamp timestamp1, Timestamp timestamp2) {
    final dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp1.millisecondsSinceEpoch);
    final dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp2.millisecondsSinceEpoch);

    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute;
  }

  // Навигация
  void back() {
    NavigatorService.goBack();
  }
}
