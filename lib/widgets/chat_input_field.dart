import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ChatInputFieldState();
  }
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isTextEmpty = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isTextEmpty.value = _controller.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: const Color(0xFFEDF2F6),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/Attach.svg',
              ),
              onPressed: () {
                // Implement attach functionality
              },
              padding: const EdgeInsets.all(6),
              iconSize: 24,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              height: 42,
              decoration: BoxDecoration(
                color: const Color(0xFFEDF2F6),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  hintText: "Сообщение",
                  border: InputBorder.none, // Remove the bottom line
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          ValueListenableBuilder<bool>(
            valueListenable: _isTextEmpty,
            builder: (context, isTextEmpty, child) {
              return Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: isTextEmpty
                      ? SvgPicture.asset('assets/icons/Audio.svg')
                      : const Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      debugPrint("Sending message: ${_controller.text}");
                      _controller.clear(); // Clear text field after sending message
                    }
                  },
                  padding: const EdgeInsets.all(6),
                  iconSize: 24,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
