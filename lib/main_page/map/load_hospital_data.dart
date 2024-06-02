import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../../const/hospital_data.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart'; // NLatLng 사용을 위해 추가

Future<List<Hospital>> loadCsvData(NLatLng currentPosition) async {
  try {
    // CSV 파일을 읽어오기
    final rawData = await rootBundle.load('asset/hospital_info/서울시동물병원인허가정보.csv');
    final rawString = utf8.decode(rawData.buffer.asUint8List(), allowMalformed: true);
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawString);

    List<Hospital> hospitals = [];

    for (var data in listData) {
      if (data.length > 28) { // 데이터 길이가 충분한 경우에만 처리
        try {
          String name = data[18]; // 사업장명
          String address = data[16]; // 도로명주소
          String phoneNumber = data[12]; // 전화번호
          double hospitalLatitude = double.parse(data[23].toString()); // 좌표정보(X)
          double hospitalLongitude = double.parse(data[24].toString()); // 좌표정보(Y)

          NLatLng hospitalPosition = NLatLng(hospitalLatitude, hospitalLongitude);
          double distanceInMeters = currentPosition.distanceTo(hospitalPosition);

          hospitals.add(Hospital(
            name: name,
            address: address,
            phoneNumber: phoneNumber,
            distance: (distanceInMeters / 1000).toStringAsFixed(1) + ' km',
            reservationAvailable: true, // 예제에서는 상태를 그대로 true로 설정합니다.
            imageUrl: 'assets/hospital_image.png', // 적절한 이미지 URL 경로로 조정 필요
            businessHours: '영업 시간 정보를 사용할 수 없습니다.', // 운영시간 정보 필드 추가 필요
            description: '병원에 대한 자세한 설명이 여기 들어갑니다.', // 설명 추가 필요
            xCoordinate: hospitalLatitude,
            yCoordinate: hospitalLongitude,
          ));
        } catch (e) {
          print("유효하지 않은 좌표 데이터가 포함된 행을 건너뜁니다: $data");
        }
      } else {
        print("데이터 행이 처리하기에 너무 짧습니다: $data");
      }
    }

    // 병원을 거리 순으로 정렬
    hospitals.sort((a, b) {
      double distanceA = double.parse(a.distance.split(' ')[0]);
      double distanceB = double.parse(b.distance.split(' ')[0]);
      return distanceA.compareTo(distanceB);
    });

    return hospitals;
  } catch (e) {
    print('데이터 로드 중 오류 발생: $e');
    throw Exception('데이터 로드에 실패했습니다');
  }
}
