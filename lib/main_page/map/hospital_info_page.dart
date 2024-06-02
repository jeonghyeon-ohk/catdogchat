import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';  // Assuming this file is in the same directory
import 'hospital_detail_page.dart';
import 'load_hospital_data.dart'; // Adjust the import path as needed
import 'package:flutter_naver_map/flutter_naver_map.dart'; // NLatLng 사용을 위해 추가

class HospitalInfoPage extends StatelessWidget {
  final ScrollController scrollController;
  final NLatLng currentPosition;

  HospitalInfoPage({
    super.key,
    required this.scrollController,
    required this.currentPosition,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Hospital>>(
      future: loadCsvData(currentPosition),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
            return Center(child: Text('데이터 로드에 실패했습니다.'));
          }
          if (snapshot.hasData) {
            print('Loaded ${snapshot.data!.length} hospitals');
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
                  subtitle: Text('운영시간: ${hospital.businessHours}\n주소: ${hospital.address}\n거리: ${hospital.distance}'),
                  trailing: Text(hospital.reservationAvailable ? '예약 가능' : '예약 불가'),
                );
              },
            );
          } else {
            print('No data found');
          }
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
