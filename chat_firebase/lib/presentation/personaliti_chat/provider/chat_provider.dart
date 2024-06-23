// lib/presentation/auth_screen/provider/chat_provider.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/app_export.dart';
import '../../../data/models/chat/chat_model.dart';
import '../../../servises/auth_servises.dart';
import '../../../servises/data_base_messages.dart';
import '../../../servises/image_service.dart';

// lib/presentation/auth_screen/provider/chat_provider.dart



class ChatProvider extends ChangeNotifier {
  final ChatService _chatService = ChatService();
  String? _currentChatId;
  List<ChatMessage> _messages = [];
  final ImageService _imageService = ImageService();
  File? photo;  // Добавляем переменную для хранения выбранного изображения
  UploadTask? uploadTask;

  String? get currentChatId => _currentChatId;
  List<ChatMessage> get messages => _messages;

  Future<void> createChat(String userId1, String userId2) async {
    _currentChatId = await _chatService.createChat(userId1, userId2);
    notifyListeners();
  }

  Stream<List<ChatMessage>> getMessages() {
    if (_currentChatId != null) {
      return _chatService.getMessages(_currentChatId!).map((messages) {
        updateMessages(messages);
        return messages;
      });
    }
    return const Stream.empty();
  }

  Future<void> sendMessage(ChatMessage message) async {
    if (_currentChatId != null) {
      final currentTime = message.timestamp;
      Timestamp? timeChangeDate;

      if (_messages.isNotEmpty) {
        final lastMessage = _messages.last;
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
        imageUrl: message.imageUrl,  //! Добавлено поле imageUrl
      );

      await _chatService.sendMessage(_currentChatId!, updatedMessage);
    }
  }

  void updateMessages(List<ChatMessage> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }

  bool isSameMinute(Timestamp timestamp1, Timestamp timestamp2) {
    final dateTime1 = DateTime.fromMillisecondsSinceEpoch(timestamp1.millisecondsSinceEpoch);
    final dateTime2 = DateTime.fromMillisecondsSinceEpoch(timestamp2.millisecondsSinceEpoch);

    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute;
  }

  Future<void> pickImage(ImageSource source) async {
    photo = await _imageService.pickImage(source);  // Выбор изображения из галереи или камеры
    if (photo != null) {
      notifyListeners();  // Уведомляем слушателей об изменении состояния
      print(photo);
      showImageDialog();  //! Вызов функции для показа диалогового окна
    }
  }

  Future<void> showImageSource(BuildContext context) async {
    await _imageService.showImageSource(context, (ImageSource source) {
      pickImage(source);  // Выбор изображения
    });
  }

  Future<void> showImageDialog() async {
    notifyListeners();  // Уведомляем слушателей для отображения диалогового окна
  }

  Future<void> sendImageMessage(String text) async {
    if (photo != null && _currentChatId != null) {
      final imageUrl = await _imageService.uploadImage(_currentChatId!, photo!);  // Загрузка изображения в Firebase Storage
      final currentUserId = AuthService().currentUser?.uid ?? 'null';
      final currentTimestamp = Timestamp.now();
      
      ChatMessage message = ChatMessage(
        senderId: currentUserId,
        text: text,
        timestamp: currentTimestamp,
        imageUrl: imageUrl,  //! Добавляем URL изображения к сообщению
      );

      await sendMessage(message);  // Отправка сообщения с изображением
      photo = null;  // Сбрасываем выбранное изображение
      notifyListeners();
    }
  }

  void back() {
    NavigatorService.goBack();
  }
}
