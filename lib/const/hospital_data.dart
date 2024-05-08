import 'package:flutter/material.dart';

class Hospital {
  final String name;
  final String address;
  final String distance;
  final bool reservationAvailable;
  final String imageUrl;
  final String businessHours;
  final String description;
  final String phoneNumber;

  Hospital({
    required this.name,
    required this.address,
    required this.distance,
    required this.reservationAvailable,
    required this.imageUrl,
    required this.businessHours,
    required this.description,
    required this.phoneNumber,
  });
}

final List<Hospital> hospitals = [
  Hospital(
    name: '병원 이름 1',
    address: '서울시 강남구 역삼동',
    distance: '1.2km',
    reservationAvailable: true,
    imageUrl: 'assets/hospital_image_1.png',
    businessHours: '09:00 - 18:00',
    description: '이 병원은 애완동물 전문 병원으로서 ...',
    phoneNumber: '123-456-7890',
  ),
  Hospital(
    name: '병원 이름 2',
    address: '서울시 강남구 역삼동',
    distance: '2.5km',
    reservationAvailable: false,
    imageUrl: 'assets/hospital_image_2.png',
    businessHours: '08:00 - 20:00',
    description: '이 병원은 대형 병원으로서 ...',
    phoneNumber: '010-1234-5678',
  ),
  // 나머지 병원 데이터 추가
];
