import 'package:flutter/material.dart';

class HospitalDetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('병원 이름'),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints.expand(height: 200.0),
              child: Image.asset(
                'assets/hospital_image.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              '병원 이름',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              '거리: 1.2km',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '위치',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '위치정보',
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    height: 200.0, // 일단 공간만 만듭니다.
                    color: Colors.grey[300], // 지도 위치정보를 나타내는 부분
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '영업시간',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '영업시간 정보',
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '소개',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '병원 소개글',
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    '전화번호',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    '전화번호 정보',
                  ),
                  SizedBox(height: 10.0),
                  ElevatedButton(
                    onPressed: () {
                      // 전화하기 기능 추가
                    },
                    child: Text('전화하기'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // 홈페이지 이동 기능 추가
                    },
                    child: Text('홈페이지'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}