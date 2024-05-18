import 'package:flutter/material.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  OpenAIAssistant assistant = OpenAIAssistant();
  String response = '';

  @override
  void initState() {
    super.initState();
    startChatbot();
  }

  void startChatbot() async {
    try {
      var assistantId = await assistant.createAssistant();
      var threadId = await assistant.createThread();
      await assistant.sendMessage(threadId, "I need to solve the equation `3x + 11 = 14`. Can you help me?");
      var messages = await assistant.pollMessages(threadId);
      setState(() {
        response = messages[0]['content'];
      });
    } catch (e) {
      setState(() {
        response = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(response),
    );
  }
}
