import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import '../models/vehicle.dart';
import '../widgets/vehicle_card.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  // Demo-Daten (später von Supabase laden)
  late List<Vehicle> _vehicles;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadDemoVehicles();
  }

  void _loadDemoVehicles() {
    _vehicles = [
      Vehicle(
        id: '1',
        userId: 'user1',
        title: 'Toyota Hiace Campervan',
        description: 'Perfect for backpackers! Fully equipped with bed, kitchen, and solar panels.',
        make: 'Toyota',
        model: 'Hiace',
        year: 2018,
        price: 8500,
        mileage: 145000,
        fuelType: 'diesel',
        transmission: 'manual',
        location: const LatLng(-33.8688, 151.2093),
        city: 'Sydney',
        state: 'NSW',
        status: 'available',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        sellerName: 'John D.',
      ),
      Vehicle(
        id: '2',
        userId: 'user2',
        title: 'Ford Transit Camper',
        description: 'Recently renovated. New tyres, battery, and registration. Ready for adventures!',
        make: 'Ford',
        model: 'Transit',
        year: 2020,
        price: 12000,
        mileage: 98000,
        fuelType: 'diesel',
        transmission: 'manual',
        location: const LatLng(-37.8136, 144.9631),
        city: 'Melbourne',
        state: 'VIC',
        status: 'available',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(days: 5)),
        sellerName: 'Sarah M.',
      ),
      Vehicle(
        id: '3',
        userId: 'user3',
        title: 'VW Transporter T5',
        description: 'Iconic VW camper with pop-top roof. Drives like a dream!',
        make: 'Volkswagen',
        model: 'Transporter',
        year: 2019,
        price: 15500,
        mileage: 112000,
        fuelType: 'diesel',
        transmission: 'automatic',
        location: const LatLng(-27.4698, 153.0251),
        city: 'Brisbane',
        state: 'QLD',
        status: 'available',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        sellerName: 'Mike R.',
      ),
      Vehicle(
        id: '4',
        userId: 'user4',
        title: 'Mitsubishi Delica 4WD',
        description: '4x4 perfect for outback adventures. Dual fuel system. Reliable and spacious.',
        make: 'Mitsubishi',
        model: 'Delica',
        year: 2017,
        price: 9800,
        mileage: 178000,
        fuelType: 'petrol',
        transmission: 'automatic',
        location: const LatLng(-31.9505, 115.8605),
        city: 'Perth',
        state: 'WA',
        status: 'available',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        sellerName: 'Emma L.',
      ),
      Vehicle(
        id: '5',
        userId: 'user5',
        title: 'Nissan Caravan Camper',
        description: 'Budget-friendly option. Good condition, just needs some love!',
        make: 'Nissan',
        model: 'Caravan',
        year: 2016,
        price: 7200,
        mileage: 225000,
        fuelType: 'diesel',
        transmission: 'manual',
        location: const LatLng(-34.9285, 138.6007),
        city: 'Adelaide',
        state: 'SA',
        status: 'available',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(days: 10)),
        sellerName: 'Tom B.',
      ),
      Vehicle(
        id: '6',
        userId: 'user6',
        title: 'Toyota Landcruiser',
        description: 'Legendary 4WD. Perfect for remote travel. Roof tent included!',
        make: 'Toyota',
        model: 'Landcruiser',
        year: 2015,
        price: 22000,
        mileage: 198000,
        fuelType: 'diesel',
        transmission: 'automatic',
        location: const LatLng(-12.4634, 130.8456),
        city: 'Darwin',
        state: 'NT',
        status: 'available',
        images: [],
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        sellerName: 'David W.',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alle Anzeigen'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Filter kommt bald!')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Suche kommt bald!')),
              );
            },
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: _vehicles.length,
                itemBuilder: (context, index) {
                  final vehicle = _vehicles[index];
                  return VehicleCard(
                    vehicle: vehicle,
                    onTap: () => _showVehicleDetails(vehicle),
                  );
                },
              ),
            ),
    );
  }

  Future<void> _onRefresh() async {
    // TODO: Echte Daten von Supabase laden
    await Future.delayed(const Duration(seconds: 1));
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Daten aktualisiert!')),
      );
    }
  }

  void _showVehicleDetails(Vehicle vehicle) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Details für ${vehicle.fullTitle}'),
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {},
        ),
      ),
    );
    // TODO: Navigation zur Detail-Seite
  }
}
