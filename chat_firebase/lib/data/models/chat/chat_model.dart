import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final String senderId;
  final Timestamp timestamp;
  final String? imageUrl;

  ChatMessage({
    required this.text,
    required this.senderId,
    required this.timestamp,
    this.imageUrl,
  });

  // Метод для преобразования объекта сообщения в Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': timestamp,
      'imageUrl': imageUrl,
    };
  }

  // Фабрика для создания объекта сообщения из Map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'],
      senderId: map['senderId'],
      timestamp: map['timestamp'],
      imageUrl: map['imageUrl'],
    );
  }
}
