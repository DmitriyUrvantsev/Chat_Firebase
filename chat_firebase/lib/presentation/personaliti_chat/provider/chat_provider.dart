import 'package:flutter/widgets.dart';

// chat_provider.dart
import 'package:flutter/material.dart';

import '../../../data/models/chat/chat_model.dart';
import '../../../servises/data_base_messages.dart';


class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  String? _currentChatId;
  List<ChatMessage> _messages = [];

  String? get currentChatId => _currentChatId;
  List<ChatMessage> get messages => _messages;

  Future<void> createChat(String userId1, String userId2) async {
    _currentChatId = await _chatService.createChat(userId1, userId2);
    notifyListeners();
  }

  Stream<List<ChatMessage>> getMessages() {
    if (_currentChatId != null) {
      return _chatService.getMessages(_currentChatId!);
    }
    return const Stream.empty();
  }

  Future<void> sendMessage(ChatMessage message) async {
    if (_currentChatId != null) {
      await _chatService.sendMessage(_currentChatId!, message);
    }
  }

  void updateMessages(List<ChatMessage> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }
}
