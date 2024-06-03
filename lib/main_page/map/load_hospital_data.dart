import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:csv/csv.dart';
import '../../const/hospital_data.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart'; // NLatLng 사용을 위해 추가

Future<List<Hospital>> loadCsvData(NLatLng currentPosition) async {
  try {
    // CSV 파일을 읽어오기
    final rawData = await rootBundle.loadString('asset/hospital_info/서울시동물병원인허가정보1.csv');
    List<List<dynamic>> listData = const CsvToListConverter().convert(rawData);

    List<Hospital> hospitals = [];

    for (var data in listData) {
      if (data.length >= 32) { // 데이터 길이가 충분한 경우에만 처리
        try {
          String name = data[18]; // 사업장명
          String address = data[16]; // 도로명주소
          String phoneNumber = data[12]; // 전화번호
          double hospitalLatitude = double.parse(data[23].toString()); // 좌표정보(X)
          double hospitalLongitude = double.parse(data[24].toString()); // 좌표정보(Y)
          String businessHours = data[30]; // 진료시간
          String locationInfo = data[31]; // 위치정보
          String website = data[32]; // 홈페이지

          NLatLng hospitalPosition = NLatLng(hospitalLatitude, hospitalLongitude);
          double distanceInMeters = currentPosition.distanceTo(hospitalPosition);

          // 이미지 경로 설정
          String imageUrl = 'asset/img/hospital/$name.png';
          bool imageExists;
          try {
            await rootBundle.load(imageUrl);
            imageExists = true;
          } catch (e) {
            imageExists = false;
          }

          if (!imageExists) {
            imageUrl = 'asset/img/dogmarker.png';
          }

          hospitals.add(Hospital(
            name: name,
            address: address,
            phoneNumber: phoneNumber,
            distance: (distanceInMeters / 1000).toStringAsFixed(1) + ' km',
            reservationAvailable: true,
            imageUrl: imageUrl, // 이미지 URL 설정
            businessHours: businessHours, // 진료시간 설정
            description: '병원에 대한 자세한 설명이 여기 들어갑니다.', // 설명 추가 필요
            xCoordinate: hospitalLatitude,
            yCoordinate: hospitalLongitude,
            locationInfo: locationInfo, // 위치정보 추가
            website: website, // 홈페이지 추가
          ));

          // 로그 출력
          print('Name: $name, Address: $address, Phone Number: $phoneNumber, Latitude: $hospitalLatitude, Longitude: $hospitalLongitude, Business Hours: $businessHours, Distance: ${(distanceInMeters / 1000).toStringAsFixed(1)} km, Image URL: $imageUrl, Location Info: $locationInfo, Website: $website');
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
