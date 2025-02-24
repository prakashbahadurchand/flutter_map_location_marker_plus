import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker_plus/flutter_map_location_marker_plus.dart';
import 'package:latlong2/latlong.dart';

class CustomizeMarkerExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customize Marker Example'),
      ),
      body: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(27.7219375, 85.322578125),
          initialZoom: 20,
          minZoom: 12,
          maxZoom: 21,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName:
                'net.tlserver6y.flutter_map_location_marker.example',
            maxZoom: 21,
          ),
          CurrentLocationLayer(
            style: LocationMarkerStyle(
              marker: const DefaultLocationMarker(
                color: Colors.green,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size.square(40),
              accuracyCircleColor: Colors.green.withOpacity(0.1),
              headingSectorColor: Colors.green.withOpacity(0.8),
              headingSectorRadius: 120,
            ),
            moveAnimationDuration: Duration.zero, // disable animation
          ),
        ],
      ),
    );
  }
}
