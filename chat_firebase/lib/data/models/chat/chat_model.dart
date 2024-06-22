import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final String senderId;
  final Timestamp timestamp;
    final Timestamp? timeChangeDate; // Одна переменная для времени начала переписки и даты смены времени
  final String? imageUrl;

  ChatMessage({
    required this.text,
    required this.senderId,
    required this.timestamp,
     this.timeChangeDate,
    this.imageUrl,
  });

  // Метод для преобразования объекта сообщения в Map
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'senderId': senderId,
      'timestamp': timestamp,
      'timeChangeDate': timeChangeDate,
      'imageUrl': imageUrl,
    };
  }

  // Фабрика для создания объекта сообщения из Map
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      text: map['text'],
      senderId: map['senderId'],
      timestamp: map['timestamp'],
      timeChangeDate: map['timeChangeDate'],
      imageUrl: map['imageUrl'],
    );
  }
}