import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/hospital_data.dart';

class HospitalDetailPage extends StatelessWidget {
  final Hospital hospital;

  HospitalDetailPage({
    required this.hospital,
    super.key,
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $launchUri';
    }
  }

  Future<void> _launchWebsite(String url) async {
    final Uri launchUri = Uri.parse(url);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text('병원 상세 정보'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 병원 사진
            Image.asset(
              hospital.imageUrl,
              height: screenHeight * 0.3,  // 화면 높이의 30% 사용
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenHeight * 0.02),
            // 병원 이름
            Text(
              hospital.name,
              style: TextStyle(
                fontSize: screenWidth * 0.06,  // 화면 너비의 6%로 폰트 크기 설정
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.01),
            // 병원 거리
            Text(
              '거리: ${hospital.distance}',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.01),
            // 병원 주소
            Text(
              '주소: ${hospital.address}',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.01),
            // 병원 영업시간
            Text(
              '운영시간: ${hospital.businessHours}',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.01),
            // 병원 소개글
            Text(
              hospital.description,
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.015),
            // 병원 전화번호
            Text(
              '전화번호: ${hospital.phoneNumber}',
              style: TextStyle(fontSize: screenWidth * 0.04),
            ),
            SizedBox(height: screenHeight * 0.03),

            // 전화하기 기능 버튼
            ElevatedButton(
              onPressed: () => _makePhoneCall(hospital.phoneNumber),
              child: Text('전화하기'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.blue),
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: screenHeight * 0.015)),
              ),
            ),
            SizedBox(height: screenHeight * 0.02),

            // 홈페이지 이동 버튼 (여기서는 병원의 URL 정보가 필요함)
            ElevatedButton(
              onPressed: () => _launchWebsite('https://example.com'), // 예시 URL; 실제 URL 정보가 필요함
              child: Text('홈페이지로 이동'),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.green),
                padding: WidgetStateProperty.all(EdgeInsets.symmetric(vertical: screenHeight * 0.015)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}