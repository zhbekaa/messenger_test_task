import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:messenger_test_task/domain/models/chat_models.dart';
import 'package:messenger_test_task/widgets/chat_bubble.dart';
import 'package:messenger_test_task/widgets/chat_input_field.dart';
import 'package:messenger_test_task/widgets/text_divider.dart';

class ChatScreen extends StatelessWidget {
  final Chat chat;

  const ChatScreen({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<DateTime> messageDates = [];

    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: CircleAvatar(
            child: Text(chat.userName[0]),
          ),
          title: Text(
            chat.userName,
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: chat.messages.length,
              itemBuilder: (context, index) {
                final message = chat.messages[index];
                DateTime messageDate = message.timestamp;
                debugPrint(messageDate.toString());
                String formattedDate = DateFormat('dd.MM.yy').format(messageDate);

                // Check if this message's date is different from the previous one
                bool showDivider = true;
                if (index > 0) {
                  DateTime previousMessageDate = chat.messages[index - 1].timestamp;
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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: messageWidgets,
                );
              },
            ),
          ),
          const ChatInputField(),
        ],
      ),
    );
  }
}
