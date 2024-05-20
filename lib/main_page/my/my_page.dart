import 'package:flutter/material.dart';

class MyPage extends StatelessWidget {
  final BoxDecoration sectionDecoration = BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.grey[300]!),
      bottom: BorderSide(color: Colors.grey[300]!),
    ),
  );

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지', style: TextStyle(fontWeight: FontWeight.bold, fontSize: screenWidth * 0.05)),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userInfoSection(sectionDecoration: sectionDecoration, screenWidth: screenWidth),
            _buildDivider(screenWidth),
            _petInfoSection(screenWidth: screenWidth),
            _buildDivider(screenWidth),
            _userSettingSection(sectionDecoration: sectionDecoration, screenWidth: screenWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider(double screenWidth) {
    return Container(
      height: screenWidth * 0.005,
      color: Colors.grey[300],
    );
  }
}

class _userInfoSection extends StatelessWidget {
  final BoxDecoration sectionDecoration;
  final double screenWidth;

  const _userInfoSection({
    required this.sectionDecoration,
    required this.screenWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenWidth * 0.25,
      decoration: sectionDecoration,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: screenWidth * 0.02, horizontal: screenWidth * 0.03),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OOO님 안녕하세요!',
              style: TextStyle(fontSize: screenWidth * 0.05, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: screenWidth * 0.01),
            Text(
              'qwerty@naver.com',
              style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
            ),
          ],
        ),
      ),
    );
  }
}

class _petInfoSection extends StatelessWidget {
  final double screenWidth;

  const _petInfoSection({required this.screenWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenWidth * 0.02),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed('/petEdit'); // 반려동물 추가 페이지로 이동
        },
        child: Container(
          height: screenWidth * 0.2,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(screenWidth * 0.013),
            border: Border(
              top: BorderSide(color: Colors.grey[300]!),
              bottom: BorderSide(color: Colors.grey[300]!),
            ),
          ),
          padding: EdgeInsets.all(screenWidth * 0.02),
          child: Row(
            children: [
              Icon(Icons.add, color: Colors.grey, size: screenWidth * 0.07),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  '반려동물 추가',
                  style: TextStyle(color: Colors.grey, fontSize: screenWidth * 0.04),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _userSettingSection extends StatelessWidget {
  final BoxDecoration sectionDecoration;
  final double screenWidth;

  const _userSettingSection({
    required this.sectionDecoration,
    required this.screenWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SettingItem(
          title: '회원정보 수정',
          icon: Icons.navigate_next,
          onPressed: () => Navigator.of(context).pushNamed('/editProfile'),
          textColor: Colors.black,
          fontSize: screenWidth * 0.04,
        ),
        Divider(),
        SettingItem(
          title: '비밀번호 변경',
          icon: Icons.navigate_next,
          onPressed: () => Navigator.of(context).pushNamed('/password'),
          textColor: Colors.black,
          fontSize: screenWidth * 0.04,
        ),
        Divider(),
        SettingItem(
          title: '로그아웃',
          onPressed: () => Navigator.of(context).pushNamed('/logout'),
          textColor: Colors.grey,
          fontSize: screenWidth * 0.04,
        ),
        SettingItem(
          title: '탈퇴',
          onPressed: () => Navigator.of(context).pushNamed('/withdraw'),
          textColor: Colors.grey,
          fontSize: screenWidth * 0.04,
        ),
      ],
    );
  }
}

// SettingItem 위젯을 필요에 따라 설정
class SettingItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color textColor;
  final double fontSize;
  final VoidCallback onPressed;

  const SettingItem({
    required this.title,
    this.icon,
    required this.textColor,
    required this.onPressed,
    required this.fontSize,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: fontSize * 0.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: textColor, fontSize: fontSize)),
            if (icon != null) Icon(icon, size: fontSize),
          ],
        ),
      ),
    );
  }
}