import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../domain/models/chat_models.dart';
import '../widgets/chat_preview.dart';

// ignore: use_key_in_widget_constructors
class ChatListScreen extends StatelessWidget {
  final List<Chat> chats = [
    Chat(
      userName: "Алиса",
      messages: [
        ChatMessage(
          text: "Привет!",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 1)),
        ),
        ChatMessage(
          text: "Привет, как дела?",
          isSentByMe: false,
          timestamp: DateTime.now(),
        ),
      ],
    ),
    Chat(
      userName: "Боб",
      messages: [
        ChatMessage(
          text:
              "Мы еще встречаемся сегодня? Мы еще встречаемся сегодня? Мы еще встречаемся сегодня? Мы еще встречаемся сегодня? Мы еще встречаемся сегодня? Мы еще встречаемся сегодня? Мы еще встречаемся сегодня? Мы еще встречаемся сегодня?",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
        ),
        ChatMessage(
          text: "Да, увидимся в 5!",
          isSentByMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
      ],
    ),
    Chat(
      userName: "Кэрол",
      messages: [
        ChatMessage(
          text: "Привет!",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        ),
        ChatMessage(
          text: "Привет Кэрол, как прошел день?",
          isSentByMe: false,
          timestamp: DateTime.now().subtract(const Duration(minutes: 50)),
        ),
        ChatMessage(
          text: "Все отлично, спасибо!",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 45)),
        ),
      ],
    ),
    Chat(
      userName: "Виктор власов",
      messages: [
        ChatMessage(
            text: "Сделай мне кофе пожалуйста!",
            isSentByMe: true,
            timestamp:
                DateFormat('dd-MM-yyyy HH:mm').parse('27-01-2023 21:44')),
        ChatMessage(
            text: "Хорошо",
            isSentByMe: false,
            timestamp:
                DateFormat('dd-MM-yyyy HH:mm').parse('27-01-2023 21:44')),
        ChatMessage(
          text: "Уже сделал?",
          isSentByMe: true,
          timestamp: DateTime.now().subtract(const Duration(minutes: 40)),
        ),
      ],
    ),
    Chat(
      userName: "Дэвид",
      messages: [
        ChatMessage(
          text: "Привет Дэвид, ты видел новый фильм?",
          isSentByMe: false,
          timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        ),
        ChatMessage(
          text: "Еще нет, он хороший?",
          isSentByMe: true,
          timestamp:
              DateTime.now().subtract(const Duration(hours: 1, minutes: 55)),
        ),
        ChatMessage(
          text: "Да, он очень хороший!",
          isSentByMe: false,
          timestamp:
              DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
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
            style: TextStyle(
                color: Colors.black,
                fontSize: 32), // Ensure text color is white
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return Column(children: [ChatPreview(chat: chat), const Divider()]);
        },
      ),
    );
  }
}
