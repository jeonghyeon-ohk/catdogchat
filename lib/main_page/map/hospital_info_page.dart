import 'package:flutter/material.dart';
import '../../const/hospital_data.dart';  // Assuming this file is in the same directory
import 'hospital_detail_page.dart';

class HospitalInfoPage extends StatelessWidget {
  final ScrollController scrollController;
  final List<Hospital> hospitals;

  HospitalInfoPage({
    super.key,
    required this.scrollController,
    required this.hospitals,
  });

  @override
  Widget build(BuildContext context) {
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
          title: Text(hospital.name, style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text('주소: ${hospital.address}\n거리: ${hospital.distance}'),
        );
      },
    );
  }
}
