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
          children: [
            _userInfoSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _petInfoSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _buildSection(sectionDecoration: sectionDecoration),
            _buildDivider(),
            _buildSection(sectionDecoration: sectionDecoration),
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

class _buildSection extends StatelessWidget {
  final BoxDecoration sectionDecoration;
  const _buildSection({
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
        child: Center(
          child: Text(
            'example',
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
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
  final BoxDecoration sectionDecoration;
  const _petInfoSection({
    required this.sectionDecoration,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        4.0,
        0.0,
        4.0,
        4.0,
      ),
      child: Container(
        decoration: sectionDecoration,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              child: Text(
                '반려동물 0', // 예시로 반려동물 수를 넣었습니다. 실제 데이터를 넣어주세요.
                style: TextStyle(
                  fontSize: 20.0,
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
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0), // 모서리가 둥근 사각형
                  border: Border(
                    top: BorderSide(color: Colors.grey[300]!),
                    bottom: BorderSide(color: Colors.grey[300]!),
                  ),
                ),
                padding: EdgeInsets.symmetric(
                    vertical: 8.0, horizontal: 16.0), // 좌우 패딩 조정
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
