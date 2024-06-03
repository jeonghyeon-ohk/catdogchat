class Hospital {
  final String name;
  final String address;
  final String phoneNumber;
  final String distance;
  final bool reservationAvailable;
  final String imageUrl;
  final String businessHours;
  final String description;
  final double xCoordinate;
  final double yCoordinate;
  final String locationInfo; // 위치정보 추가
  final String website; // 홈페이지 추가

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
    required this.locationInfo, // 위치정보 추가
    required this.website, // 홈페이지 추가
  });
}
