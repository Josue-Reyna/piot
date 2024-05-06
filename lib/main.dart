import 'package:piet_bot/chat_screen.dart';
import 'package:piet_bot/constants.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  await dotenv.load(fileName: "dotenv");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Piot',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Gabarito',
        primaryColor: white,
        primaryColorLight: white,
        inputDecorationTheme: InputDecorationTheme(
          isDense: true,
          fillColor: Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: black,
              width: 2,
            ),
          ),
        ),
      ),
      home: const ChatScreen(),
    );
  }
}
