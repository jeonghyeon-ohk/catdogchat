import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // MediaQuery를 활용하여 화면의 너비와 높이 값을 가져옵니다.
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('Change Password', style: TextStyle(fontSize: screenWidth * 0.05)),  // 제목 텍스트의 크기를 화면 너비에 따라 조정
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),  // 컨테이너의 패딩도 화면 너비에 따라 조정
        alignment: Alignment.center,
        child: Text(
          'Change Password',
          style: TextStyle(
            fontSize: screenWidth * 0.045,  // 본문 텍스트의 크기를 화면 너비에 따라 조정
          ),
        ),
      ),
    );
  }
}