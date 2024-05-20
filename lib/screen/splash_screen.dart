import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../login/login_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
          () => Navigator.of(context).pushNamed('/login'),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFD0BE9F),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.08,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'CatDotChat',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'parisienne',
                  fontSize: screenWidth * 0.14,  // 동적 폰트 크기
                ),
              ),
              Text(
                '반려동물 상담챗봇',
                style: TextStyle(
                  color: Colors.white54,
                  fontFamily: 'sunflower',
                  fontSize: screenWidth * 0.08,  // 동적 폰트 크기
                ),
              ),
              Image.asset(
                'asset/img/logo.png',
                width: screenWidth * 0.4,  // 이미지 너비 동적 조절
                height: screenHeight * 0.4, // 이미지 높이 동적 조절
              ),
              SizedBox(
                height: screenHeight * 0.05,
              ),
              CircularProgressIndicator(
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}