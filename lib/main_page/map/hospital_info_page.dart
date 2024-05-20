import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';
import 'hospital_detail_page.dart';

class HospitalInfoPage extends StatelessWidget {
  HospitalInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('동물병원'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 검색 기능 추가
            },
          ),
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: HospitalInfoList(),
    );
  }
}

class HospitalInfoList extends StatelessWidget {
  HospitalInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width; // 화면의 너비를 기반으로 요소들의 크기 조절

    return ListView.builder(
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        final hospital = hospitals[index];
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HospitalDetailPage(hospital: hospital),
              ),
            );
          },
          leading: CircleAvatar(
            // 병원 이미지 설정 및 크기 조절
            backgroundImage: AssetImage(hospital.imageUrl),
            radius: screenWidth * 0.07, // 화면 너비에 따라 아이콘 크기 조절
          ),
          title: Text(
            hospital.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // 글자 크기를 화면 너비에 따라 조절
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '운영시간: ${hospital.businessHours}\n주소: ${hospital.address}',
                style: TextStyle(
                  fontSize: screenWidth * 0.035, // 화면 너비를 기반으로 글자 크기 조정
                ),
              ),
              Text(
                '거리: ${hospital.distance}',
                style: TextStyle(
                  fontSize: screenWidth * 0.035,
                ),
              ),
            ],
          ),
          trailing: Text(
            hospital.reservationAvailable ? '예약 가능' : '예약 불가',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: screenWidth * 0.04, // 화면 너비에 따른 글자 크기 조정
            ),
          ),
        );
      },
    );
  }
}