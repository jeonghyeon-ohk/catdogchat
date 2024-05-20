import 'package:flutter/material.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 화면 너비
    double screenHeight = MediaQuery.of(context).size.height; // 화면 높이

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: TextStyle(fontSize: screenWidth * 0.05), // 제목의 문자 크기 동적 조정
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05), // 컨테이너 여백 동적 조정
        alignment: Alignment.center,
        child: Text(
          'Edit Profile',
          style: TextStyle(fontSize: screenWidth * 0.04), // 본문의 문자 크기 동적 조정
        ),
      ),
    );
  }
}