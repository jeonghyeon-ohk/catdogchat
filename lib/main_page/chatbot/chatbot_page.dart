import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter/foundation.dart';

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
  String _selectedAnimal = '';
  String _selectedCondition = '';

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

and you are capable of analyzing image, so if user wants to show you an image you can just tell them show you an image file.
""";

  Future<void> sendMessage(String content, {bool shouldPrint = true}) async {
    if (shouldPrint) {
      setState(() {
        _messages.add({
          "role": "user",
          "content": content,
        });
        _messageController.clear(); // 입력 필드를 초기화합니다.
        _messages.add({
          // '서버로부터 응답을 기다리는 중입니다...' 메시지를 추가합니다.
          "role": "assistant",
          "content": "서버로부터 응답을 기다리는 중입니다...",
        });
      });
    } else {
      setState(() {
        _messages.add({
          // '서버로부터 응답을 기다리는 중입니다...' 메시지를 추가합니다.
          "role": "assistant",
          "content": "서버로부터 응답을 기다리는 중입니다...",
        });
      });
    }

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
              "content": message['content'] == "서버로부터 응답을 기다리는 중입니다..."
                  ? null
                  : message['content'], // Update message conditionally
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
          _messages.removeLast(); // '서버로부터 응답을 기다리는 중입니다...' 메시지를 제거합니다.
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
    String url;
    if (_selectedAnimal == '강아지') {
      url = _selectedCondition == '피부'
          ? 'http://13.48.15.160:5000/predict_dogskin'
          : 'http://13.48.15.160:5000/predict_dogeyes';
    } else {
      url = _selectedCondition == '피부'
          ? 'http://13.48.15.160:5000/predict_catskin'
          : 'http://13.48.15.160:5000/predict_cateyes';
    }

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(url), // Dynamic URL based on user selection
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
          double aiServerResponseProb = data['probabilities'];
          String aiServerResponseProbString = aiServerResponseProb.toString();

          String combinedResponse =
              "{$aiServerResponseSpecies, $aiServerResponsePrediction, $aiServerResponseProbString}";
          // Send AI server response to GPT-4
          await sendMessageToGpt(combinedResponse);
        } else {
          setState(() {
            _messages.add({
              "role": "assistant",
              "content":
              "Error: The key 'prediction' was not found in the server response.",
            });
          });
        }
      } else {
        setState(() {
          _messages.add({
            "role": "assistant",
            "content":
            "Error: Server responded with status code ${response.statusCode}",
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
      _messages.add({
        // '서버로부터 응답을 기다리는 중입니다...' 메시지를 추가합니다.
        "role": "assistant",
        "content": "서버로부터 응답을 기다리는 중입니다...",
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
            }, //여기 지금 콤마가 있어도 되는지 모르겠음 혹시 안되면 지워
          ],
          'max_tokens': 1000,
          'temperature': 0.5,
        })),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(utf8.decode(response.bodyBytes));
        setState(() {
          _messages.removeLast(); // '서버로부터 응답을 기다리는 중입니다...' 메시지를 제거합니다.
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
            "content":
            "Error: ${response.reasonPhrase}\n${errorData['error']['message']}",
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
    await _showAnimalSelectionDialog();
  }

  Future<void> _showAnimalSelectionDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('동물 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Image.asset('asset/img/dog_icon.png',
                    width: 40, height: 40),
                title: Text('강아지'),
                onTap: () {
                  setState(() {
                    _selectedAnimal = '강아지';
                  });
                  Navigator.of(context).pop();
                  _showConditionSelectionDialog();
                },
              ),
              ListTile(
                leading: Image.asset('asset/img/cat_icon.png',
                    width: 40, height: 40),
                title: Text('고양이'),
                onTap: () {
                  setState(() {
                    _selectedAnimal = '고양이';
                  });
                  Navigator.of(context).pop();
                  _showConditionSelectionDialog();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _showConditionSelectionDialog() async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('질환 유형 선택'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.pets, size: 40, color: Colors.brown),
                title: Text('피부'),
                onTap: () async {
                  setState(() {
                    _selectedCondition = '피부';
                  });
                  Navigator.of(context).pop();
                  await _pickImageFromGallery();
                },
              ),
              ListTile(
                leading:
                Icon(Icons.remove_red_eye, size: 40, color: Colors.blue),
                title: Text('안구'),
                onTap: () async {
                  setState(() {
                    _selectedCondition = '안구';
                  });
                  Navigator.of(context).pop();
                  await _pickImageFromGallery();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      print("\n\n\nthis is where cropping started\n\n\n");
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: false,
              hideBottomControls: true,
              showCropGrid: true,
              cropFrameColor: Colors.white,
              cropGridColor: Colors.red),
          IOSUiSettings(
            title: 'Cropper',
            minimumAspectRatio: 1.0,
            aspectRatioLockEnabled: true,
            rotateButtonsHidden: false,
            rotateClockwiseButtonHidden: true,
            aspectRatioLockDimensionSwapEnabled: true,
            resetAspectRatioEnabled: false,
            doneButtonTitle: 'Finish',
            cancelButtonTitle: 'Cancel',
            resetButtonHidden: true,
          )
        ],
      );

      if (croppedFile != null) {
        print("\n\n\ncrop failed\n\n\n");
        final bytes = await croppedFile.readAsBytes();
        setState(() {
          _selectedImage = bytes;
        });
      }
    }
  }


  // Future<void> _pickImageFromGallery() async {
  //   final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     final bytes = await pickedFile.readAsBytes();
  //     setState(() {
  //       _selectedImage = bytes;
  //     });
  //   }
  // }

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
                      hintStyle: TextStyle(fontSize: screenWidth * 0.035),
                      // 조절된 힌트 글씨 크기
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
                    } else if (content.isNotEmpty) {
                      await sendMessage(content, shouldPrint: true);
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
