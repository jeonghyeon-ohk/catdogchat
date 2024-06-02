class Hospital {
  final String name; // 병원 이름
  final String address; // 주소
  final String phoneNumber; // 전화번호
  final String distance; // 거리
  final bool reservationAvailable; // 예약 가능 여부
  final String imageUrl; // 이미지 URL
  final String businessHours; // 영업 시간
  final String description; // 설명
  final double xCoordinate; // X 좌표
  final double yCoordinate; // Y 좌표

  Hospital({
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.distance,
    required this.reservationAvailable,
    required this.imageUrl,
    required this.businessHours,
    required this.description,
    required this.xCoordinate,
    required this.yCoordinate,
  });
}
