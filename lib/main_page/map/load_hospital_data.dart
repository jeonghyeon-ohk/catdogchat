import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../../const/hospital_data.dart';
import 'package:geolocator/geolocator.dart';

Future<List<Hospital>> loadCsvData() async {
  final rawData = await rootBundle.loadString('lib/assets/your_csv_file.csv');
  List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

  // 현재 위치 가져오기
  Position currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

  List<Hospital> hospitals = listData.map((data) {
    // 병원의 위치
    final double hospitalLatitude = double.parse(data[27]);
    final double hospitalLongitude = double.parse(data[28]);

    // 거리 계산
    double distanceInMeters = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      hospitalLatitude,
      hospitalLongitude,
    );

    return Hospital(
      name: data[21],
      address: data[20],
      phoneNumber: data[16],
      distance: (distanceInMeters / 1000).toStringAsFixed(2) + ' km',  // km 단위로 변환
      reservationAvailable: true,
      imageUrl: 'assets/hospital_image.png',
      businessHours: '09:00 - 18:00',
      description: '병원에 대한 설명',
      xCoordinate: hospitalLatitude,
      yCoordinate: hospitalLongitude,
    );
  }).toList();

  return hospitals;
}