class Hospital {
  final String name;
  final String address;
  final String distance;
  final bool reservationAvailable;
  final String imageUrl;
  final String businessHours;
  final String description;
  final String phoneNumber;
  final double xCoordinate;  // x좌표
  final double yCoordinate;  // y좌표

  Hospital({
    required this.name,
    required this.address,
    required this.distance,
    required this.reservationAvailable,
    required this.imageUrl,
    required this.businessHours,
    required this.description,
    required this.phoneNumber,
    required this.xCoordinate,
    required this.yCoordinate,
  });
}