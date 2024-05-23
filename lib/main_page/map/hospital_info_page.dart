import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';
import 'load_hospital_data.dart'; // loadCsvData 함수가 있는 파일
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

    return FutureBuilder<List<Hospital>>(
      future: loadCsvData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('데이터 로드에 실패했습니다.'));
          }

          if (snapshot.hasData) {
            return ListView.builder(
              controller: scrollController,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final hospital = snapshot.data![index];
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
                  title: Text(hospital.name, style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '운영시간: ${hospital.businessHours}\n주소: ${hospital.address}',
                        style: TextStyle(fontSize: screenHeight * 0.02),
                      ),
                      Text(
                        '거리: ${hospital.distance}',
                        style: TextStyle(fontSize: screenHeight * 0.02),
                      ),
                    ],
                  ),
                  trailing: Text(
                    hospital.reservationAvailable ? '예약 가능' : '예약 불가',
                    style: TextStyle(fontSize: screenHeight * 0.02),
                  ),
                );
              },
            );
          }
        }

        // 로딩 중 표시
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}