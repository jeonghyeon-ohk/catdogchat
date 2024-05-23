import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
  final String? apiKey = dotenv.env['ChatBotKey'];
  final String model = "gpt-4";
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String?>> _messages = [];
  Uint8List? _selectedImage;

  @override
  void initState() {
    super.initState();
    _addInitialBotMessage();
  }

  void _addInitialBotMessage() {
    setState(() {
      _messages.add({
        "role": "assistant",
        "content": "반려동물에 관한 질문이 있으신가요? 도와드릴 수 있어요",
      });
      _messages.add({
        "role": "assistant",
        "content": "또는 반려동물의 피부 혹은 안구 사진을 첨부해주시면 어떤 질환인지 판단해드릴게요",
      });
    });
  }

  final String instruction = """
This GPT, the Pet Health Assistant, is specifically designed for Korean-speaking users.It provides general insights into pets' health based on symptoms or behaviors described in Korean. If a user does not specify the type of pet, the GPT will ask the user to specify the animal type before proceeding with advice. In non-emergency, everyday situations, this GPT will incorporate light humor in its responses to keep the interaction engaging. It offers potential causes and solutions in Korean before suggesting a consultation with a professional for definitive advice. It is essential for the GPT to guide users towards professional help without giving definite diagnoses, ensuring all interactions are in Korean. Additionally, when users ask questions with unclear subjects such as 'What should I eat tonight?' or 'Which exercise would be good?', the GPT will assume the subject is the user's pet and respond accordingly.

if user input data with format{species, disease, probability} then i want you to understand as AI-server says "it seems to pet has disease with this much probability". And after that explain how to manage it.
""";

  Future<void> sendMessage(String content) async {
    setState(() {
      _messages.add({
        "role": "user",
        "content": content,
      });
      _messageController.clear(); // 입력 필드를 초기화합니다.
      _messages.add({  // '응답을 기다리는 중입니다...' 메시지를 추가합니다.
        "role": "assistant",
        "content": "응답을 기다리는 중입니다...",
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
            ..._messages
                .map((message) => {
              "role": message['role'],
              "content": message['content'] == "응답을 기다리는 중입니다..." ? null : message['content'], // Update message conditionally
            })
                .where((message) => message['content'] != null)
                .toList(),
          ],
          "max_tokens": 1000,
          "temperature": 0.5,
        })),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _messages.removeLast(); // '응답을 기다리는 중입니다...' 메시지를 제거합니다.
          _messages.add({
            "role": "assistant",
            "content": data['choices'][0]['message']['content'].trim(),
          });
        });
      } else {
        setState(() {
          _messages.removeLast();
          _messages.add({
            "role": "assistant",
            "content": "Error: ${response.reasonPhrase}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add({
          "role": "assistant",
          "content": "Error: $e",
        });
      });
    }
  }

  Future<void> sendImageToAiServer(Uint8List image) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://13.48.15.160:5000/predictcatskin'), // Replace with your AI server's URL
      );

      // Convert Uint8List to MultipartFile
      request.files.add(http.MultipartFile.fromBytes(
        'file',
        image,
        filename: 'upload.jpg', // You can use any filename you prefer
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        // Ensure the 'prediction' key exists in the response
        if (data.containsKey('prediction')) {
          String aiServerResponseSpecies = data['species'];
          String aiServerResponsePrediction = data['prediction'];
          String aiServerResponseProb = data['percentage'];

          String combinedResponse = "{$aiServerResponseSpecies, $aiServerResponsePrediction, $aiServerResponseProb}";
          // Send AI server response to GPT-4
          await sendMessageToGpt(combinedResponse);
        } else {
          setState(() {
            _messages.add({
              "role": "assistant",
              "content": "Error: The key 'prediction' was not found in the server response.",
            });
          });
        }
      } else {
        setState(() {
          _messages.add({
            "role": "assistant",
            "content": "Error: Server responded with status code ${response.statusCode}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({"role": "assistant", "content": "Error: $e"});
      });
    }
  }

  Future<void> sendMessageToGpt(String aiServerResponse) async {
    setState(() {
      _messages.add({  // '응답을 기다리는 중입니다...' 메시지를 추가합니다.
        "role": "assistant",
        "content": "응답을 기다리는 중입니다...",
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
          'model': model,
          'messages': [
            {
              'role': 'system',
              'content': instruction,
            },
            {
              'role': 'user',
              'content': aiServerResponse,
            },
            ..._messages
                .map((message) => {
              'role': message['role'],
              'content': message['content'],
            })
                .toList(),
          ],
          'max_tokens': 1000,
          'temperature': 0.5,
        })),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _messages.removeLast(); // '응답을 기다리는 중입니다...' 메시지를 제거합니다.
          _messages.add({
            "role": "assistant",
            "content": data['choices'][0]['message']['content'].trim(),
          });
        });
      } else {
        var errorData = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _messages.removeLast();
          _messages.add({
            "role": "assistant",
            "content": "Error: ${response.reasonPhrase}\n${errorData['error']['message']}",
          });
        });
      }
    } catch (e) {
      setState(() {
        _messages.removeLast();
        _messages.add({
          "role": "assistant",
          "content": "Error: $e",
        });
      });
    }
  }

  Future<void> _pickImage() async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();
      setState(() {
        _selectedImage = bytes;
      });
    }
  }

  Widget _buildImagePreview() {
    return _selectedImage == null
        ? Container()
        : SizedBox(
      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.memory(_selectedImage!), // Use Image.memory
      ),
    );
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
                  leading: isUser
                      ? null
                      : SizedBox(
                      width: screenWidth * 0.1,
                      child: Image.asset('asset/img/logo.png')),
                  title: Align(
                    alignment:
                    isUser ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: screenWidth * 0.02,
                          horizontal: screenWidth * 0.04),
                      decoration: BoxDecoration(
                        color: isUser ? Colors.blue[300] : Colors.grey[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        message['content'] ?? '',
                        style: TextStyle(
                            color: isUser ? Colors.white : Colors.black,
                            fontSize: screenWidth * 0.035),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          _buildImagePreview(),
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: '반려동물의 상태를 문의해 주세요!',
                      hintStyle: TextStyle(
                          fontSize: screenWidth * 0.035), // 조절된 힌트 글씨 크기
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      fillColor: Colors.grey[200],
                      filled: true,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.photo),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send, size: screenWidth * 0.07),
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    final content = _messageController.text;

                    // 이미지가 선택되었으면 서버에 이미지 전송
                    if (_selectedImage != null) {
                      await sendImageToAiServer(_selectedImage!);
                      setState(() {
                        _selectedImage = null;
                      });
                    }

                    // 입력된 텍스트가 존재하면 메시지 전송
                    if (content.isNotEmpty) {
                      await sendMessage(content);
                      _messageController.clear(); // 입력 필드를 초기화
                    }
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
