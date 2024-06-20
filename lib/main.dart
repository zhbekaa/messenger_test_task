import 'package:flutter/material.dart';
import 'package:messenger_test_task/firebase_options.dart';
import 'package:messenger_test_task/screens/chat_list_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.white,
            primary: Colors.white,
            onPrimary: Colors.black,
            surface: Colors.white),
      ),
      home: const Scaffold(body: ChatListScreen()),
    );
  }
}
