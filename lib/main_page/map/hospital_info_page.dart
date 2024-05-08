import 'package:flutter/material.dart';

class HospitalInfoPage extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    // 임시 병원 데이터
    final List<Hospital> hospitals = [
      Hospital(
        name: '병원 이름 1',
        address: '서울시 강남구 역삼동',
        distance: '1.2km',
        reservationAvailable: true,
      ),
      Hospital(
        name: '병원 이름 2',
        address: '서울시 강남구 역삼동',
        distance: '2.5km',
        reservationAvailable: false,
      ),
      // 나머지 병원 데이터 추가
    ];

    return ListView.builder(
      itemCount: hospitals.length,
      itemBuilder: (context, index) {
        final hospital = hospitals[index];
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
            // 1. 병원 사진
            backgroundImage: AssetImage('assets/hospital_image.png'),
          ),
          title: Text(
            // 2. 병원 이름
            hospital.name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                // 3. 운영시간, 병원 주소
                '운영시간: 09:00 - 18:00\n주소: ${hospital.address}',
              ),
              Text(
                // 4. 나한테부터 떨어진 거리
                '거리: ${hospital.distance}',
              ),
            ],
          ),
          trailing: Text(
            // 5. 예약 가능 여부
            hospital.reservationAvailable ? '예약 가능' : '예약 불가',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
}

class Hospital {
  final String name;
  final String address;
  final String distance;
  final bool reservationAvailable;

  Hospital({
    required this.name,
    required this.address,
    required this.distance,
    required this.reservationAvailable,
  });
}

class HospitalDetailPage extends StatelessWidget {
  final Hospital hospital;

  HospitalDetailPage({required this.hospital});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(hospital.name),
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
              hospital.name,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5.0),
            Text(
              '거리: ${hospital.distance}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            // 나머지 병원 정보 표시
          ],
        ),
      ),
    );
  }
}
