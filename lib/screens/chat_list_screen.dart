import 'package:flutter/material.dart';
import 'package:messenger_test_task/domain/services/chat_service.dart';
import '../domain/models/chat_models.dart';
import '../widgets/chat_preview.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  ChatListScreenState createState() => ChatListScreenState();
}

class ChatListScreenState extends State<ChatListScreen> {
  late Future<List<Chat>> _chatsFuture;
  final ChatService _chatService = ChatService();
  final List<Chat> reserveChats = [
    Chat(userName: 'Виктор Власов', messages: [
      ChatMessage(
          text: 'Можешь сделать мне кофе пожалуйста',
          isSentByMe: true,
          timestamp: DateTime.now())
    ]),
  ];
  @override
  void initState() {
    super.initState();
    _chatsFuture = _chatService.fetchChats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(
            'Чаты',
            style: TextStyle(color: Colors.black, fontSize: 32),
          ),
        ),
      ),
      body: FutureBuilder<List<Chat>>(
          future: _chatsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Ошибка: ${snapshot.error}'));
            }

            List<Chat> chats = (snapshot.data?.isEmpty ?? true)
                ? reserveChats
                : snapshot.data!;
            return ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return Column(
                  children: [
                    ChatPreview(chat: chat),
                    const Divider(),
                  ],
                );
              },
            );
          }),
    );
  }
}
