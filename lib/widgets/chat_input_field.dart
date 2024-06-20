import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:messenger_test_task/domain/models/chat_models.dart';
import 'package:messenger_test_task/domain/services/chat_service.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class ChatInputField extends StatefulWidget {
  const ChatInputField({
    super.key,
    required this.receiverId,
    required this.onMessageSubmitted,
  });

  final String receiverId;
  final ValueChanged<ChatMessage> onMessageSubmitted;

  @override
  State<StatefulWidget> createState() {
    return _ChatInputFieldState();
  }
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();
  final ValueNotifier<bool> _isTextEmpty = ValueNotifier(true);
  final _chatService = ChatService();
  final AudioRecorder _record = AudioRecorder();
  String imageUrl = '';
  String? audioUrl;
  bool isRecording = false;
  late Directory appDocDir;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      _isTextEmpty.value = _controller.text.isEmpty;
    });
    _initAppDir();
  }

  Future<void> _initAppDir() async {
    appDocDir = await getApplicationDocumentsDirectory();
  }

  Future<void> sendMessage(
      String message, String? imageUrl, String? audioUrl) async {
    if (message.isNotEmpty || imageUrl != null || audioUrl != null) {
      final newMessage = ChatMessage(
        text: message,
        isSentByMe: true,
        timestamp: DateTime.now(),
        imageUrl: imageUrl,
        audioUrl: audioUrl,
      );
      widget.onMessageSubmitted(newMessage);
      _controller.clear();
      setState(() {
        this.imageUrl = '';
        this.audioUrl = null;
      });
      await _chatService.sendMessage(
          widget.receiverId, message, imageUrl, audioUrl);
    }
  }

  Future<void> selectImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result == null || result.files.single.path == null) {
      return;
    }
    File file = File(result.files.single.path!);
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages
        .child(DateTime.now().microsecondsSinceEpoch.toString());

    try {
      await referenceImageToUpload.putFile(file);
      String downloadUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        imageUrl = downloadUrl;
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void deleteImage() {
    setState(() {
      imageUrl = '';
    });
  }

  Future<void> startRecording() async {
    final path = '${appDocDir.path}/${const Uuid().v4()}.m4a';
    await _record.start(const RecordConfig(), path: path);
    setState(() {
      isRecording = true;
    });
  }

  Future<void> stopRecording() async {
    final path = await _record.stop();
    if (path != null) {
      final file = File(path);
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('audios/${const Uuid().v4()}.m4a');
      await ref.putFile(file);
      audioUrl = await ref.getDownloadURL();
      sendMessage('', null, audioUrl);
      setState(() {
        isRecording = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _record.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (imageUrl.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      imageUrl,
                      height: 100, // Adjust height as needed
                      fit: BoxFit.cover,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close),
                    onPressed: deleteImage,
                  ),
                ],
              ),
            ),
          Row(
            children: <Widget>[
              Container(
                width: 42,
                height: 42,
                decoration: BoxDecoration(
                  color: const Color(0xFFEDF2F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: SvgPicture.asset('assets/icons/Attach.svg'),
                  onPressed: selectImage,
                  padding: const EdgeInsets.all(6),
                  iconSize: 24,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: isRecording
                    ? Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF2F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.mic,
                              color: Colors.red,
                            ),
                            SizedBox(width: 8),
                            Text(
                              "Запись...",
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(
                        height: 42,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEDF2F6),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: TextField(
                          controller: _controller,
                          decoration: const InputDecoration(
                            hintText: "Сообщение",
                            border: InputBorder.none,
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
                    child: isTextEmpty && imageUrl.isEmpty
                        ? GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onLongPress: startRecording,
                            onLongPressEnd: (_) => stopRecording(),
                            child: Padding(
                              padding: const EdgeInsets.all(6),
                              child: SvgPicture.asset(
                                'assets/icons/Audio.svg',
                                colorFilter: isRecording
                                    ? const ColorFilter.mode(
                                        Colors.red, BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                        Colors.black, BlendMode.srcIn),
                              ),
                            ),
                          )
                        : IconButton(
                            onPressed: () {
                              if (_controller.text.isNotEmpty ||
                                  imageUrl.isNotEmpty ||
                                  audioUrl != null) {
                                debugPrint(
                                    "Sending message: ${_controller.text}");
                                sendMessage(
                                    _controller.text, imageUrl, audioUrl);
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(6),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(
                              Icons.send,
                              color: Colors.black,
                              size: 24,
                            ),
                          ),
                  );
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
