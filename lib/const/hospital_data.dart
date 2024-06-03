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
