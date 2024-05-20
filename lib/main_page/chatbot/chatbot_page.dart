import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final String apiKey = "sk-proj-9RJWJitV6GK8ihWJKmDRT3BlbkFJ7arCRY4px1KaKXn95w8n"; // Replace with your actual API key
  final String model = "gpt-4"; // 모델 이름
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String?>> _messages = [];

  @override
  void initState() {
    super.initState();
    _addInitialBotMessage();
  }

  void _addInitialBotMessage() {
    // 초기 챗봇 메시지 추가
    setState(() {
      _messages.add({
        "role": "assistant",
        "content": "안녕하세요! 반려동물에 관한 질문이 있으신가요? 도와드릴 수 있어요"
      });
    });
  }

  final String instruction = """
This GPT, the Pet Health Assistant, is specifically designed for Korean-speaking users...
""";

  Future<void> sendMessage(String content) async {
    setState(() {
      _messages.add({
        "role": "user",
        "content": content,
      });
    });

    try {
      var response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $apiKey',
        },
        body: utf8.encode(jsonEncode({
          "model": model,
          "messages": [
            {"role": "system", "content": instruction},
            ..._messages.map((message) => {"role": message['role'], "content": message['content']}).toList(),
          ],
          "max_tokens": 1000,
          "temperature": 0.5,
        })),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _messages.add({
            "role": "assistant",
            "content": data['choices'][0]['message']['content'].trim(),
          });
        });
      } else {
        setState(() {
          _messages.add({
            "role": "assistant",
            "content": "Error: ${response.reasonPhrase}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "assistant", "content": "Error: $e"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('반려동물 챗봇'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  var message = _messages[index];
                  bool isUser = message['role'] == 'user';
                  return ListTile(
                    leading: isUser ? null : CircleAvatar(backgroundImage: AssetImage("assets/bot_icon.png")),
                    title: Align(
                      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: isUser ? Colors.blue : Colors.green[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(message['content'] ?? '', style: TextStyle(color: isUser ? Colors.white : Colors.black)),
                      ),
                    ),
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '메시지 입력...',
                      fillColor: Colors.grey[200],
                      filled: true,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      sendMessage(_messageController.text);
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}