import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:messenger_test_task/domain/models/chat_models.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverName, String text) async {
    final DateTime timestamp = DateTime.now();
    final ChatMessage message =
        ChatMessage(text: text, isSentByMe: true, timestamp: timestamp);

    await _firestore.collection('chats').doc(receiverName).collection('messages').add(message.toMap());
  } 

  Future<List<Chat>> fetchChats() async {
    final firestore = FirebaseFirestore.instance;
    final chatDocs = await firestore.collection('chats').get();

    List<Chat> chats = [];

    for (var chatDoc in chatDocs.docs) {
      final messagesQuery =
          await chatDoc.reference.collection('messages').get();
      final messages = messagesQuery.docs
          .map((msgDoc) => ChatMessage.fromFirestore(msgDoc.data()))
          .toList();

      chats.add(Chat(userName: chatDoc.id, messages: messages));
    }

    return chats;
  }
}
