class ChatMessage {
  final String text;
  final bool isSentByMe;
  final DateTime timestamp;
  ChatMessage({required this.text, required this.isSentByMe, required this.timestamp});
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