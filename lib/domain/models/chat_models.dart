import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;
  ChatMessage({
    required this.text,
    required this.isSentByMe,
    required this.timestamp,
  });
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'timestamp': Timestamp.fromDate(timestamp),
      'isSentByMe': true
    };
  }
   factory ChatMessage.fromFirestore(Map<String, dynamic> data) {
    return ChatMessage(
      text: data['text'] ?? '',
      isSentByMe: data['isSentByMe'] ?? false,
      timestamp: (data['timestamp'] as Timestamp).toDate(),
    );
  }
}

class Chat {
  final String userName;
  final List<ChatMessage> messages;

  Chat({
    required this.userName,
    required this.messages,
  });

  ChatMessage get lastMessage => messages.last;
  
}