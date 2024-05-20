import 'package:flutter/material.dart';

class Withdraw extends StatelessWidget {
  const Withdraw({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 화면의 너비를 가져옴
    double screenHeight = MediaQuery.of(context).size.height; // 화면의 높이를 가져옴

    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw', style: TextStyle(fontSize: screenWidth * 0.05)),  // 타이틀 크기를 화면 너비에 맞춰 조절
      ),
      body: Container(
        padding: EdgeInsets.all(screenWidth * 0.05),  // 컨테이너의 패딩을 화면 너비에 맞춰 조절
        alignment: Alignment.center,
        child: Text(
          'Are you sure you want to withdraw your account?',
          style: TextStyle(
            fontSize: screenWidth * 0.045,  // 텍스트 크기를 화면 너비에 맞춰 조절
            color: Colors.red,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // 계정 삭제 로직 추가
        },
        child: Icon(Icons.delete_forever),
        backgroundColor: Colors.red,
      ),
    );
  }
}