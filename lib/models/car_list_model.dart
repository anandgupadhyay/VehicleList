class Car {

  final String model;

  final String owner;
  final DateTime serviceDate;

  final DateTime insuranceDueDate;
  final double price;
  final double rating;

  Car({
    required this.model,
    required this.owner,
    required this.serviceDate,
    required this.insuranceDueDate,
    required this.price,
    required this.rating,
  });
}
