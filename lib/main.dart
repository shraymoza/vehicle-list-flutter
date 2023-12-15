import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'VehicleDetailsScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VehicleProvider(),
      child: MaterialApp(
        title: 'Flutter REST Vehicle App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Consumer<VehicleProvider>(
          builder: (context, vehicleProvider, _) {
            if (vehicleProvider.isLoading) {
              return SplashScreen();
            } else {
              return HomeScreen();
            }
          },
        ),
      ),
    );
  }
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            FlutterLogo(size: 150),
            SizedBox(height: 20),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final vehicleProvider = Provider.of<VehicleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Available Vehicles'),
      ),
      body: ListView.builder(
        itemCount: vehicleProvider.vehicles.length,
        itemBuilder: (context, index) {
          final vehicle = vehicleProvider.vehicles[index];
          return ListTile(
            title: Text(vehicle['name']),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VehicleDetailsScreen(vehicle: vehicle),
                ),
              );
            },
          );
        },
      ),
    );
  }
}



class VehicleProvider with ChangeNotifier {
  List<Map<String, dynamic>> _vehicles = [];
  bool _isLoading = true;

  List<Map<String, dynamic>> get vehicles => _vehicles;
  bool get isLoading => _isLoading;

  Future<void> fetchVehicles() async {
    final response = await http.get(Uri.parse('https://swapi.dev/api/vehicles/'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> results = data['results'];

      for (var vehicle in results) {
        _vehicles.add(vehicle);
      }

      _isLoading = false;
      notifyListeners();
    } else {
      throw Exception('Failed to load vehicles');
    }
  }

  VehicleProvider() {
    fetchVehicles();
  }
}
