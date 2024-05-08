import 'package:catdogchat/main_page/map/hospital_detail_page.dart';
import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';

class HospitalInfoPage extends StatelessWidget {
  HospitalInfoPage({
    super.key,
  });

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
  HospitalInfoList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: hospitals.length, // hospitals 리스트의 길이로 아이템 수 설정
      itemBuilder: (context, index) {
        final hospital = hospitals[index]; // hospitals 리스트에서 해당 인덱스의 병원 정보 가져오기
        return ListTile(
          onTap: () {
            // 해당 병원의 상세 페이지로 이동
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HospitalDetailPage(hospital: hospital),
              ),
            );
          },
          leading: CircleAvatar(
            // 병원 사진
            backgroundImage: AssetImage(hospital.imageUrl),
          ),
          title: Text(
            // 병원 이름
            hospital.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 운영시간, 주소
                '운영시간: ${hospital.businessHours}\n주소: ${hospital.address}',
              ),
              Text(
                // 거리
                '거리: ${hospital.distance}',
              ),
            ],
          ),
          trailing: Text(
            // 예약 가능 여부
            hospital.reservationAvailable ? '예약 가능' : '예약 불가',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}
