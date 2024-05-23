import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../../const/hospital_data.dart'; // 적절한 경로 조정이 필요합니다.
import 'package:geolocator/geolocator.dart';

Future<List<Hospital>> loadCsvData() async {
  try {
    final rawData = await rootBundle.loadString('asset/hospital_info/hospitaldata.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);
    Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    List<Hospital> hospitals = [];

    for (var data in listData) {
      if (data.length > 28) {
        String name = data[21];
        String address = data[20];
        String phoneNumber = data[16];
        double hospitalLatitude = double.parse(data[27]);
        double hospitalLongitude = double.parse(data[28]);
        double distanceInMeters = Geolocator.distanceBetween(
            currentPosition.latitude, currentPosition.longitude, hospitalLatitude, hospitalLongitude);

        hospitals.add(Hospital(
          name: name,
          address: address,
          phoneNumber: phoneNumber,
          distance: (distanceInMeters / 1000).toStringAsFixed(2) + ' km',
          reservationAvailable: true, // 예제에서는 상태를 그대로 true로 설정합니다.
          imageUrl: 'assets/hospital_image.png', // 적절한 이미지 URL 경로로 조정 필요
          businessHours: 'No information available', // 운영시간 정보 필드 추가 필요
          description: '병원에 대한 자세한 설명이 여기 들어갑니다.', // 설명 추가 필요
          xCoordinate: hospitalLatitude,
          yCoordinate: hospitalLongitude,
        ));
      } else {
        print("Data row is too short to process: $data");
      }
    }
    return hospitals;
  } catch (e) {
    print('Error loading data: $e');
    throw Exception('Failed to load data');
  }
}