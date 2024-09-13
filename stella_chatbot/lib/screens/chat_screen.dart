// lib/screens/chat_screen.dart
import 'package:flutter/material.dart';
import 'package:stella_chatbot/models/user.dart';
import 'package:stella_chatbot/models/message.dart';
import 'package:stella_chatbot/services/chat_service.dart';
import 'package:stella_chatbot/widgets/chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  final User user;

  ChatScreen({required this.user});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ChatService _chatService = ChatService();
  final TextEditingController _messageController = TextEditingController();
  List<Message> _messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() async {
    final messages = await _chatService.getMessages(widget.user.id);
    setState(() {
      _messages = messages;
    });
  }

  void _sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      final message = await _chatService.sendMessage(widget.user.id, _messageController.text);
      setState(() {
        _messages.add(message);
        _messageController.clear();
      });
      
      // Simulate bot response
      final botResponse = await _chatService.getBotResponse(widget.user.id, message.content);
      setState(() {
        _messages.add(botResponse);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat with Stella'),
        backgroundColor: Colors.purple[700],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.purple[100]!, Colors.purple[300]!],
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  return ChatBubble(message: _messages[index]);
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.send),
                    onPressed: _sendMessage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}