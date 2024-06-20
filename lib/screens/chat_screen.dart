import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger_test_task/domain/models/chat_models.dart';
import 'package:messenger_test_task/widgets/chat_bubble.dart';
import 'package:messenger_test_task/widgets/chat_input_field.dart';
import 'package:messenger_test_task/widgets/text_divider.dart';
class ChatScreen extends StatefulWidget {
  final Chat chat;

  const ChatScreen({super.key, required this.chat});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late Chat _chat;

  @override
  void initState() {
    super.initState();
    _chat = widget.chat;
  }

  void _addMessage(ChatMessage message) {
    setState(() {
      _chat.messages.add(message);
    });
  }

  String getFormattedDate(DateTime messageDate) {
    DateTime now = DateTime.now();

    // Check if the message was sent today
    if (now.year == messageDate.year &&
        now.month == messageDate.month &&
        now.day == messageDate.day) {
      return 'Сегодня';
    }

    // Check if the message was sent yesterday
    DateTime yesterday = now.subtract(const Duration(days: 1));
    if (yesterday.year == messageDate.year &&
        yesterday.month == messageDate.month &&
        yesterday.day == messageDate.day) {
      return 'Вчера';
    }

    // Otherwise, format the date normally
    return DateFormat('dd.MM.yy').format(messageDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            child: Text(_chat.userName[0]),
          ),
          title: Text(
            _chat.userName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: _chat.messages.length,
              itemBuilder: (context, index) {
                final message = _chat.messages[index];
                DateTime messageDate = message.timestamp;
                String formattedDate = getFormattedDate(messageDate);

                // Check if this message's date is different from the previous one
                bool showDivider = true;
                if (index > 0) {
                  DateTime previousMessageDate =
                      _chat.messages[index - 1].timestamp;
                  if (messageDate.year == previousMessageDate.year &&
                      messageDate.month == previousMessageDate.month &&
                      messageDate.day == previousMessageDate.day) {
                    showDivider = false;
                  }
                }

                // If the divider should be shown, add it before the message
                List<Widget> messageWidgets = [];
                if (showDivider) {
                  messageWidgets.add(TextDivider(text: formattedDate));
                }

                // Add the ChatBubble for the current message
                messageWidgets.add(ChatBubble(message: message));

                // Add a SizedBox for spacing between messages
                if (index < _chat.messages.length - 1) {
                  messageWidgets.add(const SizedBox(height: 10)); // Adjust the height as needed
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: messageWidgets,
                );
              },
            ),
          ),
          ChatInputField(
            receiverId: _chat.userName,
            onMessageSubmitted: (message) {
              _addMessage(message);
            },
          ),
        ],
      ),
    );
  }
}
