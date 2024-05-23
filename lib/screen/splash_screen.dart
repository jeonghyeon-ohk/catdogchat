import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
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
        child: Center(
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
                    fontSize: screenWidth * 0.14,
                  ),
                ),
                Text(
                  '반려동물 상담챗봇',
                  style: TextStyle(
                    color: Colors.white54,
                    fontFamily: 'sunflower',
                    fontSize: screenWidth * 0.08,
                  ),
                ),
                Image.asset(
                  'asset/img/logo.png',
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.3,
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
      ),
    );
  }
}