import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:messenger_test_task/domain/models/chat_models.dart';
import 'package:voice_message_package/voice_message_package.dart'; // Import your voice message package

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
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (message.imageUrl != null && message.imageUrl!.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          message.imageUrl!,
                          width: 300,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey, // Placeholder color
                              child: const Icon(Icons.error), // Error icon
                            );
                          },
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            }
                            return Container(
                              width: 100,
                              height: 100,
                              color: Colors.grey, // Placeholder color
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  if (message.audioUrl != null && message.audioUrl!.isNotEmpty)
                    VoiceMessageView(
                      backgroundColor:
                          Color(message.isSentByMe ? 0xff3CED78 : 0xffEDF2F6),
                      controller: VoiceController(
                        audioSrc: message.audioUrl!,
                        onComplete: () {
                          /// do something on complete
                        },
                        onPause: () {
                          /// do something on pause
                        },
                        onPlaying: () {
                          /// do something on playing
                        },
                        onError: (err) {
                          /// do something on error
                        },
                        maxDuration: const Duration(seconds: 10),
                        isFile: false,
                      ),
                      innerPadding: 12,
                      cornerRadius: 20,
                    ),
                  Row(
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
                      const SizedBox(width: 4),
                      Text(
                        time,
                        style: TextStyle(
                            color: message.isSentByMe
                                ? const Color(0xff00521C).withOpacity(0.8)
                                : Colors.black.withOpacity(0.8),
                            fontSize: 12),
                        softWrap: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
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
