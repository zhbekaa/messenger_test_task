import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:messenger_test_task/domain/models/chat_models.dart';

class ChatBubble extends StatelessWidget {
  final ChatMessage message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    String time = DateFormat('HH:mm').format(message.timestamp);

    return Align(
      alignment:
          message.isSentByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: message.isSentByMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment:
            CrossAxisAlignment.end, // Align tails with bottom of bubbles
        children: [
          if (!message.isSentByMe) ...[
            SvgPicture.asset(
              'assets/icons/MessageLeftTail.svg',
              width: 20,
              height: 20,
            ),
          ],
          Flexible(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                margin: EdgeInsets.zero,
                decoration: BoxDecoration(
                  color: Color(message.isSentByMe ? 0xff3CED78 : 0xffEDF2F6),
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(21),
                    topRight: const Radius.circular(21),
                    bottomLeft: message.isSentByMe
                        ? const Radius.circular(21)
                        : Radius.zero,
                    bottomRight: message.isSentByMe
                        ? Radius.zero
                        : const Radius.circular(21),
                  ),
                ),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Flexible(
                        child: Text(
                          message.text,
                          style: TextStyle(
                              color: message.isSentByMe
                                  ? const Color(0xff00521C)
                                  : Colors.black,
                              fontSize: 14),
                          softWrap: true,
                        ),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            color: message.isSentByMe
                                ? const Color(0xff00521C).withOpacity(0.8)
                                : Colors.black.withOpacity(0.8),
                            fontSize: 12),
                        softWrap: true,
                      )
                    ])),
          ),
          if (message.isSentByMe)
            SvgPicture.asset(
              'assets/icons/MessageRightTail.svg',
              width: 20,
              height: 20,
            ),
        ],
      ),
    );
  }
}
