import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: ChatbotPage(),
    theme: ThemeData(
      primarySwatch: Colors.blue,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
  ));
}

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final String apiKey = "sk-proj-9RJWJitV6GK8ihWJKmDRT3BlbkFJ7arCRY4px1KaKXn95w8n";
  final String model = "gpt-4";
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String?>> _messages = [];

  @override
  void initState() {
    super.initState();
    _addInitialBotMessage();
  }

  void _addInitialBotMessage() {
    setState(() {
      _messages.add({
        "role": "assistant",
        "content": "안녕하세요! 반려동물에 관한 질문이 있으신가요? 도와드릴 수 있어요"
      });
    });
  }

  Future<void> sendMessage(String content) async {
    // API 호출 및 로직 구현
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Image.asset(
              'asset/img/logo2.png',
              fit: BoxFit.contain,
              height: screenWidth * 0.07,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text('캣독 챗', style: TextStyle(fontSize: screenWidth * 0.05)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                var message = _messages[index];
                bool isUser = message['role'] == 'user';
                return ListTile(
                  leading: isUser ? null : SizedBox(width: screenWidth * 0.1, child: Image.asset('asset/img/logo.png')),
                  title: Align(
                    alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02, horizontal: screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[300] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['content'] ?? '',
                        style: TextStyle(color: isUser ? Colors.white : Colors.black, fontSize: screenWidth * 0.035),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '반려동물의 상태를 문의해 주세요!',
                      hintStyle: TextStyle(fontSize: screenWidth * 0.035), // 조절된 힌트 글씨 크기
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: IconButton(icon: Icon(Icons.camera_alt), onPressed: () {}),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, size: screenWidth * 0.07),
                  onPressed: () {
                    // 메시지 전송 로직
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('카테고리를 선택하세요')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ListTile(
            title: Text('안구'),
            leading: Icon(Icons.visibility),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('피부'),
            leading: Icon(Icons.texture),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}