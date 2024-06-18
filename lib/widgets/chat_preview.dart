import 'package:flutter/material.dart';
import 'package:messenger_test_task/screens/chat_screen.dart';

import '../domain/models/chat_models.dart';

class ChatPreview extends StatelessWidget {
  final Chat chat;

  const ChatPreview({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    final message =
        chat.lastMessage.isSentByMe ? 'Вы: ${chat.lastMessage.text}' : chat.lastMessage.text;

    return ListTile(
      leading: CircleAvatar(
        child: Text(chat.userName[0]),
      ),
      title: Text(chat.userName),
      subtitle: Text(message),
      trailing: Text(
        _formatTimestamp(chat.lastMessage.timestamp),
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => ChatScreen(chat: chat)));
      },
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return "${timestamp.hour}:${timestamp.minute}";
  }
}
