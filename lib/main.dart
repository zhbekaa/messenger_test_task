import 'package:flutter/material.dart';
import 'package:messenger_test_task/screens/chat_list_screen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.white,
        primary: Colors.white,
        onPrimary: Colors.black,
        background: Colors.white,
      )),
      home: Scaffold(body: ChatListScreen()),
    );
  }
}
