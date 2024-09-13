import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stella_chatbot/screens/login_screen.dart';
import 'package:stella_chatbot/services/auth_service.dart';
import 'package:stella_chatbot/services/chat_service.dart';
import 'package:stella_chatbot/services/database_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final databaseService = DatabaseService();
  await databaseService.connect();

  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<ChatService>(create: (_) => ChatService()),
        Provider<DatabaseService>.value(value: databaseService),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stella Parenting Chatbot',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginScreen(),
    );
  }
}