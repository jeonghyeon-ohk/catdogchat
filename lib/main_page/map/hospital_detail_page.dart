import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../const/hospital_data.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

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
        title: Row(
          children: [
            Image.asset(
              'asset/img/logo2.png',
              fit: BoxFit.contain,
              height: screenWidth * 0.07,
            ),
            SizedBox(width: screenWidth * 0.02),
            Text(
              hospital.name,
              style: TextStyle(fontSize: screenWidth * 0.05),
            ),
          ],
        ),
        centerTitle: true, // AppBar 타이틀 가운데 정렬
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenWidth * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 병원 사진
            Image.asset(
              hospital.imageUrl,
              height: screenHeight * 0.3, // 화면 높이의 30% 사용
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: screenHeight * 0.03),
            // 병원 이름
            Text(
              hospital.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: screenWidth * 0.07, // 화면 너비의 7%로 폰트 크기 설정
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),
            // 병원 정보
            _buildInfoRow(screenWidth, screenHeight, '거리', hospital.distance, showDivider: false),
            _buildInfoRow(screenWidth, screenHeight, '주소', hospital.address),
            SizedBox(height: screenHeight * 0.02),
            // 병원 위치 지도
            Container(
              height: screenHeight * 0.3, // 화면 높이의 30% 사용
              child: NaverMap(
                options: NaverMapViewOptions(
                  initialCameraPosition: NCameraPosition(
                    target: NLatLng(hospital.xCoordinate, hospital.yCoordinate),
                    zoom: 15,
                  ),
                ),
                onMapReady: (NaverMapController controller) {
                  final marker = NMarker(
                    id: hospital.name,
                    position: NLatLng(hospital.xCoordinate, hospital.yCoordinate),
                    icon: NOverlayImage.fromAssetImage('asset/img/logo2.png'), // 마커 이미지 설정
                    size: Size(20, 20),
                    caption: NOverlayCaption(
                      text: hospital.name,
                      textSize: 11.0,
                      color: Colors.black,
                      minZoom: 13,
                      maxZoom: 21,
                    ),
                  );
                  controller.addOverlay(marker);
                },
              ),
            ),
            if (hospital.locationInfo.isNotEmpty)
              SizedBox(height: screenHeight * 0.02),
            if (hospital.locationInfo.isNotEmpty)
              _buildInfoRow(screenWidth, screenHeight, '위치 정보', hospital.locationInfo),
            _buildInfoRow(screenWidth, screenHeight, '운영시간', '\n' + hospital.businessHours),
            _buildInfoRow(screenWidth, screenHeight, '전화번호', hospital.phoneNumber, showDivider: false),
            SizedBox(height: screenHeight * 0.04),
            // 전화하기 기능 버튼
            ElevatedButton(
              onPressed: () => _makePhoneCall(hospital.phoneNumber),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                child: Text(
                  '전화하기',
                  style: TextStyle(fontSize: screenWidth * 0.045),
                ),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
            ),
            if (hospital.website.isNotEmpty)
              SizedBox(height: screenHeight * 0.02),
            if (hospital.website.isNotEmpty)
              ElevatedButton(
                onPressed: () => _launchWebsite(hospital.website),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                  child: Text(
                    '홈페이지 방문하기',
                    style: TextStyle(fontSize: screenWidth * 0.045),
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(double screenWidth, double screenHeight, String title, String info, {bool showDivider = true}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '$title: ',
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text: info,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: screenHeight * 0.01),
          if (showDivider) Divider(thickness: 1, color: Colors.grey.withOpacity(0.5)),
        ],
      ),
    );
  }
}
