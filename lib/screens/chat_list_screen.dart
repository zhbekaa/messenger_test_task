import 'package:flutter/material.dart';
import '../domain/models/chat_models.dart';
import '../widgets/chat_preview.dart';

// ignore: use_key_in_widget_constructors
class ChatListScreen extends StatelessWidget {
  final List<Chat> chats = [
    Chat(
      userName: "Alice",
      messages: [
        ChatMessage(
          text: "Hello!",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        ),
        ChatMessage(
          text: "Hi, how are you?",
          isSentByMe: false,
          timestamp: DateTime.now(),
        ),
      ],
    ),
    Chat(
      userName: "Bob",
      messages: [
        ChatMessage(
          text:
              "Are we still on for today? Are we still on for todayAre we still on for todayAre we still on for todayAre we still on for todayAre we still on for todayAre we still on for todayAre we still on for today",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        ChatMessage(
          text: "Yes, see you at 5!",
          isSentByMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
    ),
    // Add more chats here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.zero, // Remove padding from ListTile

          title: Text(
            'Чаты',
            style: TextStyle(color: Colors.black, fontSize: 32), // Ensure text color is white
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatPreview(chat: chat);
        },
      ),
    );
  }
}

void main() => runApp(MaterialApp(
      home: ChatListScreen(),
    ));
