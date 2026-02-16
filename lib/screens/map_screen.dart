import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

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
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.directions_car, size: 40, color: Colors.orange),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carMarker.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Verkäufer: ${carMarker.seller}',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            const Divider(),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Preis',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      carMarker.price,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Details für ${carMarker.title}')),
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                  label: const Text('Details'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
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
