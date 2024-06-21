import 'package:flutter/widgets.dart';

// chat_provider.dart
import 'package:flutter/material.dart';

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
      await _chatService.sendMessage(_currentChatId!, message);
    }
  }

  // Метод для обновления списка сообщений
  void updateMessages(List<ChatMessage> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }
}
