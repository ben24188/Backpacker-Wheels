import 'package:latlong2/latlong.dart';

class Vehicle {
  final String id;
  final String userId;
  final String title;
  final String description;
  final String make;
  final String model;
  final int year;
  final double price;
  final int? mileage;
  final String? fuelType;
  final String? transmission;
  final LatLng location;
  final String? city;
  final String? state;
  final String status;
  final List<String> images;
  final DateTime createdAt;
  final String? sellerName;

  Vehicle({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.make,
    required this.model,
    required this.year,
    required this.price,
    this.mileage,
    this.fuelType,
    this.transmission,
    required this.location,
    this.city,
    this.state,
    this.status = 'available',
    this.images = const [],
    required this.createdAt,
    this.sellerName,
  });

  // Von Supabase JSON zu Vehicle
  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      description: json['description'] ?? '',
      make: json['make'],
      model: json['model'],
      year: json['year'],
      price: (json['price'] as num).toDouble(),
      mileage: json['mileage'],
      fuelType: json['fuel_type'],
      transmission: json['transmission'],
      location: LatLng(
        (json['latitude'] as num).toDouble(),
        (json['longitude'] as num).toDouble(),
      ),
      city: json['city'],
      state: json['state'],
      status: json['status'] ?? 'available',
      images: json['images'] != null 
          ? List<String>.from(json['images']) 
          : [],
      createdAt: DateTime.parse(json['created_at']),
      sellerName: json['seller_name'],
    );
  }

  // Vehicle zu Supabase JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
      'description': description,
      'make': make,
      'model': model,
      'year': year,
      'price': price,
      'mileage': mileage,
      'fuel_type': fuelType,
      'transmission': transmission,
      'latitude': location.latitude,
      'longitude': location.longitude,
      'city': city,
      'state': state,
      'status': status,
      'images': images,
    };
  }

  // Formatierter Preis
  String get formattedPrice => '\$${price.toStringAsFixed(0)}';

  // Vollständiger Titel mit Jahr
  String get fullTitle => '$year $make $model';
}
