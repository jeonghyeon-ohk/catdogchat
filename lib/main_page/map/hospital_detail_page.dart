import 'package:flutter/material.dart';

import '../../const/hospital_data.dart';

class HospitalDetailPage extends StatelessWidget {
  final Hospital hospital;

  HospitalDetailPage({
    required this.hospital,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('병원 상세 정보'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. 병원 사진
            Image.asset(
              hospital.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20.0),
            // 2. 병원 이름
            Text(
              hospital.name,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            // 3. 병원 거리
            Text(
              '거리: ${hospital.distance}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            // 4. 병원 위치정보
            Text(
              '주소: ${hospital.address}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            // 5. 병원 영업시간
            Text(
              '운영시간: ${hospital.businessHours}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            // 6. 병원 소개글
            Text(
              hospital.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10.0),
            // 7. 병원 전화번호
            Text(
              '전화번호: ${hospital.phoneNumber}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20.0),
            // 8. 전화하기 기능 버튼
            ElevatedButton(
              onPressed: () {
                // 전화하기 기능 구현
              },
              child: Text('전화하기'),
            ),
            SizedBox(height: 10.0),
            // 9. 홈페이지 이동 기능 버튼
            ElevatedButton(
              onPressed: () {
                // 홈페이지 이동 기능 구현
              },
              child: Text('홈페이지로 이동'),
            ),
          ],
        ),
      ),
    );
  }
}
