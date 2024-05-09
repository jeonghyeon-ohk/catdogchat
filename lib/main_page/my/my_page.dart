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
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '마이페이지',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _userInfoSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _petInfoSection(),
            _buildDivider(),
            _userSettingSection(sectionDecoration: sectionDecoration),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Container(
      height: 2.0,
      color: Colors.grey[300],
    );
  }
}

class _userInfoSection extends StatelessWidget {
  final BoxDecoration sectionDecoration;

  const _userInfoSection({
    required this.sectionDecoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: sectionDecoration,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OOO님 안녕하세요!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'qwerty@naver.com',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _petInfoSection extends StatelessWidget {
  final BoxDecoration? sectionDecoration;
  const _petInfoSection({
    this.sectionDecoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                '반려동물 0', // 반려동물 수, 실제 데이터 넣어야함.
                style: TextStyle(
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  '/petEdit',
                );
                // 반려동물 추가 페이지로 이동
              },
              child: Container(
                height: 75,
                width: 150,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(
                    10.0,
                  ),
                  border: Border(
                    top: BorderSide(color: Colors.grey[300]!),
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                padding: EdgeInsets.all(8.0), // 좌우 패딩 조정
                child: Row(
                  children: [
                    Icon(Icons.add, color: Colors.grey),
                    SizedBox(width: 8.0),
                    Expanded(
                      // 텍스트가 너무 길어지면 줄바꿈 처리
                      child: Text(
                        '반려동물 추가',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _userSettingSection extends StatelessWidget {
  final BoxDecoration sectionDecoration;
  const _userSettingSection({
    required this.sectionDecoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingItem(
            title: '회원정보 수정',
            icon: Icons.navigate_next,
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/editProfile',
              );
            },
          ),
        ),
        Divider(), // 구분선 추가
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingItem(
            title: '비밀번호 변경',
            icon: Icons.navigate_next,
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/password',
              );
            },
          ),
        ),
        Divider(),
        SizedBox(height: 8), // 로그아웃과 탈퇴 사이의 간격
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingItem(
            title: '로그아웃',
            textColor: Colors.grey, // 회색 글자색
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/logout',
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: SettingItem(
            title: '탈퇴',
            textColor: Colors.grey, // 회색 글자색
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/withdraw',
              );
            },
          ),
        ),
      ],
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Color textColor;
  final VoidCallback onPressed;

  const SettingItem({
    required this.title,
    this.icon,
    this.textColor = Colors.black,
    required this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 16.0,
              ),
            ),
            if (icon != null) Icon(icon),
          ],
        ),
      ),
    );
  }
}
