import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/vehicle.dart';
import 'vehicle_detail_screen.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  
  // Demo-Standorte für Autos in Australien
  final List<CarMarker> _demoCarMarkers = [
    CarMarker(
      position: const LatLng(-33.8688, 151.2093), // Sydney
      title: 'Toyota Hiace 2018',
      price: '\$8,500',
      seller: 'John D.',
    ),
    CarMarker(
      position: const LatLng(-37.8136, 144.9631), // Melbourne
      title: 'Ford Transit 2020',
      price: '\$12,000',
      seller: 'Sarah M.',
    ),
    CarMarker(
      position: const LatLng(-27.4698, 153.0251), // Brisbane
      title: 'VW Transporter 2019',
      price: '\$15,500',
      seller: 'Mike R.',
    ),
    CarMarker(
      position: const LatLng(-31.9505, 115.8605), // Perth
      title: 'Mitsubishi Delica 2017',
      price: '\$9,800',
      seller: 'Emma L.',
    ),
    CarMarker(
      position: const LatLng(-34.9285, 138.6007), // Adelaide
      title: 'Nissan Caravan 2016',
      price: '\$7,200',
      seller: 'Tom B.',
    ),
    CarMarker(
      position: const LatLng(-12.4634, 130.8456), // Darwin
      title: 'Toyota Landcruiser 2015',
      price: '\$22,000',
      seller: 'David W.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map - Auto-Standorte'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _centerOnAustralia,
            tooltip: 'Australien zentrieren',
          ),
        ],
      ),
      body: Stack(
        children: [
          // OpenStreetMap
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: const LatLng(-25.2744, 133.7751), // Zentrum von Australien
              initialZoom: 4.0,
              minZoom: 3.0,
              maxZoom: 18.0,
            ),
            children: [
              // Tile Layer (OpenStreetMap)
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.backpackerwheels.backpacker_wheels',
                maxZoom: 19,
              ),
              
              // Marker Layer (Auto-Standorte)
              MarkerLayer(
                markers: _demoCarMarkers.map((carMarker) {
                  return Marker(
                    point: carMarker.position,
                    width: 40,
                    height: 40,
                    child: GestureDetector(
                      onTap: () => _showCarDetails(carMarker),
                      child: const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          
          // Info-Card oben
          Positioned(
            top: 10,
            left: 10,
            right: 10,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline, color: Colors.orange),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        '${_demoCarMarkers.length} Autos zum Verkauf',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Filter-Dialog öffnen
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Filter-Funktion kommt bald!')),
          );
        },
        icon: const Icon(Icons.filter_list),
        label: const Text('Filter'),
      ),
    );
  }

  void _centerOnAustralia() {
    _mapController.move(const LatLng(-25.2744, 133.7751), 4.0);
  }

  void _showCarDetails(CarMarker carMarker) {
    // Erstelle ein temporäres Vehicle für Demo
    final vehicle = Vehicle(
      id: carMarker.title,
      userId: 'demo',
      title: carMarker.title,
      description: 'Perfect campervan for your Australian adventure!',
      make: carMarker.title.split(' ')[0],
      model: carMarker.title.split(' ').skip(1).join(' '),
      year: int.parse(carMarker.title.split(' ').last),
      price: double.parse(carMarker.price.replaceAll(RegExp(r'[^\d.]'), '')),
      location: carMarker.position,
      city: _getCityFromPosition(carMarker.position),
      images: [],
      createdAt: DateTime.now(),
      sellerName: carMarker.seller,
      mileage: 150000,
      transmission: 'manual',
      fuelType: 'diesel',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VehicleDetailScreen(vehicle: vehicle),
      ),
    );
  }

  String _getCityFromPosition(LatLng position) {
    if (position.latitude > -34 && position.latitude < -33) return 'Sydney';
    if (position.latitude > -38 && position.latitude < -37) return 'Melbourne';
    if (position.latitude > -28 && position.latitude < -27) return 'Brisbane';
    if (position.latitude > -32 && position.latitude < -31) return 'Perth';
    if (position.latitude > -35 && position.latitude < -34) return 'Adelaide';
    if (position.latitude > -13 && position.latitude < -12) return 'Darwin';
    return 'Australia';
  }
}

// Datenmodell für Auto-Marker (Demo)
class CarMarker {
  final LatLng position;
  final String title;
  final String price;
  final String seller;

  CarMarker({
    required this.position,
    required this.title,
    required this.price,
    required this.seller,
  });
}
