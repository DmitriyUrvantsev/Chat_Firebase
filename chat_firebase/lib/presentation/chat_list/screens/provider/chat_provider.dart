import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/app_export.dart';
import '../../../../data/models/chat/chat_model.dart';
import '../../../../servises/auth_servises.dart';
import '../../../../servises/data_base_messages.dart';
import '../../../../servises/image_service.dart';

class ChatProvider extends ChangeNotifier {
  FocusNode focusNode = FocusNode();
  final ChatService _chatService = ChatService();
  String? _currentChatId;
  List<ChatMessage> _messages = [];
  final ImageService _imageService = ImageService();
  File? photo;
  UploadTask? uploadTask;
  
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  
  String? get currentChatId => _currentChatId;
  List<ChatMessage> get messages => _messages;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
  
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
        imageUrl: message.imageUrl,
      );
      
      await _chatService.sendMessage(_currentChatId!, updatedMessage);
    }
  }
  
  void updateMessages(List<ChatMessage> newMessages) {
    _messages = newMessages;
    notifyListeners();
  }
  
  bool isSameMinute(Timestamp timestamp1, Timestamp timestamp2) {
    final dateTime1 =
        DateTime.fromMillisecondsSinceEpoch(timestamp1.millisecondsSinceEpoch);
    final dateTime2 =
        DateTime.fromMillisecondsSinceEpoch(timestamp2.millisecondsSinceEpoch);
    
    return dateTime1.year == dateTime2.year &&
        dateTime1.month == dateTime2.month &&
        dateTime1.day == dateTime2.day &&
        dateTime1.hour == dateTime2.hour &&
        dateTime1.minute == dateTime2.minute;
  }
  
  bool shouldShowTimeChange(ChatMessage currentMessage, ChatMessage? previousMessage) {
    if (previousMessage == null) {
      return currentMessage.timeChangeDate != null;
    }
    return !isSameMinute(currentMessage.timestamp, previousMessage.timestamp);
  }
  
  Future<void> pickImage(ImageSource source) async {
    photo = await _imageService
        .pickImage(source);
    if (photo != null) {
      notifyListeners();
      print(photo);
      showImageDialog();
    }
  }
  
  Future<void> showImageSource(BuildContext context) async {
    await _imageService.showImageSource(context, (ImageSource source) {
      pickImage(source);
    });
  }
  
  Future<void> showImageDialog() async {
    notifyListeners();
  }
  
  Future<void> sendImageMessage(String text) async {
    if (photo != null && _currentChatId != null) {
      final imageUrl = await _imageService.uploadImage(
          _currentChatId!, photo!);
      final currentUserId = AuthService().currentUser?.uid ?? 'null';
      final currentTimestamp = Timestamp.now();
      
      ChatMessage message = ChatMessage(
        senderId: currentUserId,
        text: text,
        timestamp: currentTimestamp,
        imageUrl: imageUrl,
      );
      
      await sendMessage(message);
      photo = null;
      notifyListeners();
    }
  }
  
  Future<void> sendTextMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }
    
    final currentUserId = AuthService().currentUser?.uid ?? 'null';
    final currentTimestamp = Timestamp.now();
    Timestamp? timeChangeDate;
    timeChangeDate = currentTimestamp;
    
    ChatMessage message = ChatMessage(
      senderId: currentUserId,
      text: messageController.text,
      timestamp: currentTimestamp,
      timeChangeDate: timeChangeDate,
    );
    
    await sendMessage(message);
    messageController.clear();
  }
  
  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }
  
  void back() {
    _isLoading = true;
    NavigatorService.goBack();
  }
}
