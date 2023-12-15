// ignore: file_names
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VehicleDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> vehicle;
  const VehicleDetailsScreen({required this.vehicle});
  @override
  _VehicleDetailsScreenState createState() => _VehicleDetailsScreenState();
}

class _VehicleDetailsScreenState extends State<VehicleDetailsScreen> {
  Map<String, dynamic> vehicleData ={};
  var imageResp;
  String imageUrl = '';

  @override
  void initState() {
    super.initState();
    vehicleData=widget.vehicle;
    fetchVehicleImage();
  }

  Future<void> fetchVehicleImage() async {
    imageResp = await http.get(Uri.parse(vehicleData['url']));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
             // if (imageResp!=null)
             //  Image.memory(
             //    imageResp.bodyBytes,
             //    width: 200,
             //    height: 200,
             //    fit: BoxFit.cover,
             //  ),
            const SizedBox(height: 20),
            Text(
              'Name: ${vehicleData['name']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Model: ${vehicleData['model']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Manufacturer: ${vehicleData['manufacturer']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Cost: ${vehicleData['cost_in_credits']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Speed: ${vehicleData['max_atmosphering_speed']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Length: ${vehicleData['length']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Crew: ${vehicleData['crew']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Capacity: ${vehicleData['cargo_capacity']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Class: ${vehicleData['vehicle_class']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Consumables: ${vehicleData['consumables']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Passengers: ${vehicleData['passengers']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Created: ${vehicleData['created']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),Text(
              'Edited: ${vehicleData['edited']}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            // if (imageUrl.isEmpty)
            //   const Center(
            //     child: CircularProgressIndicator(),
            //   ),
          ],
        ),
      ),
    );
  }
}