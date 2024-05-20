import 'package:flutter/material.dart';

class Logout extends StatelessWidget {
  const Logout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 화면 너비
    double screenHeight = MediaQuery.of(context).size.height; // 화면 높이

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Logout',
          style: TextStyle(fontSize: screenWidth * 0.05), // 제목의 폰트 크기를 화면 너비에 비례하여 조절
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(screenWidth * 0.05), // 컨테이너의 패딩을 화면 너비에 비례하여 조절
        child: Text(
          'Logout',
          style: TextStyle(fontSize: screenWidth * 0.045), // 텍스트의 폰트 크기를 화면 너비에 비례하여 조절
        ),
      ),
    );
  }
}