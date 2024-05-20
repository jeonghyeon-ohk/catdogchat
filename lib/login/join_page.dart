import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('회원가입'),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _Id(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _Password(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              _PasswordAgain(screenWidth: screenWidth),
              SizedBox(height: screenHeight * 0.02),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/');
                },
                child: Text('회원가입'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  textStyle: TextStyle(fontSize: screenWidth * 0.045),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Id extends StatelessWidget {
  final double screenWidth;

  const _Id({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: TextField(
            decoration: InputDecoration(
              labelText: '이메일',
              hintText: '이메일 입력',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _Password extends StatelessWidget {
  final double screenWidth;

  const _Password({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호',
              hintText: '비밀번호 입력',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class _PasswordAgain extends StatelessWidget {
  final double screenWidth;

  const _PasswordAgain({Key? key, required this.screenWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.03),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: '비밀번호 확인',
              hintText: '비밀번호 재입력',
              hintStyle: TextStyle(color: Colors.grey),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}