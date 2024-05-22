import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';
import 'hospital_detail_page.dart';

class HospitalInfoPage extends StatelessWidget {
  final ScrollController scrollController;

  HospitalInfoPage({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return ListView.builder(
      controller: scrollController,
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
            backgroundImage: AssetImage(hospital.imageUrl),
          ),
          title: Text(hospital.name,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '운영시간: ${hospital.businessHours}\n주소: ${hospital.address}',
                style: TextStyle(fontSize: screenHeight * 0.02), // 글자 크기 조정
              ),
              Text(
                '거리: ${hospital.distance}',
                style: TextStyle(fontSize: screenHeight * 0.02), // 글자 크기 조정
              ),
            ],
          ),
          trailing: Text(
            hospital.reservationAvailable ? '예약 가능' : '예약 불가',
            style: TextStyle(fontSize: screenHeight * 0.02), // 글자 크기 조정
          ),
        );
      },
    );
  }
}
