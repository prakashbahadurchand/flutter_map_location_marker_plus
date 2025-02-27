import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_joystick/flutter_joystick.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker_plus/flutter_map_location_marker_plus.dart';
import 'package:latlong2/latlong.dart';

// A demo for the usage of AnimatedLocationMarkerLayer. In this example, the
// location marker is controlled by a joystick. This example provide same
// behavior as Custom Stream Example.
class NoStreamExample extends StatefulWidget {
  @override
  _NoStreamExampleState createState() => _NoStreamExampleState();
}

class _NoStreamExampleState extends State<NoStreamExample> {
  LocationMarkerPosition _currentPosition = const LocationMarkerPosition(
    latitude: 0,
    longitude: 0,
    accuracy: 0,
  );
  LocationMarkerHeading _currentHeading = const LocationMarkerHeading(
    heading: 0,
    accuracy: pi * 0.2,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('No Stream Example'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: const MapOptions(
              initialCenter: LatLng(27.7219375, 85.322578125),
              initialZoom: 20,
              minZoom: 12,
              maxZoom: 21,
            ),
            // ignore: sort_child_properties_last
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName:
                    'net.tlserver6y.flutter_map_location_marker.example',
                maxZoom: 21,
              ),
              AnimatedLocationMarkerLayer(
                position: _currentPosition,
                heading: _currentHeading,
              ),
            ],
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Joystick(
              listener: (details) {
                setState(() {
                  _currentPosition = LocationMarkerPosition(
                    latitude:
                        (_currentPosition.latitude - details.y).clamp(-85, 85),
                    longitude: (_currentPosition.longitude + details.x)
                        .clamp(-180, 180),
                    accuracy: 0,
                  );
                  if (details.x != 0 || details.y != 0) {
                    _currentHeading = LocationMarkerHeading(
                      heading:
                          (atan2(details.y, details.x) + pi * 0.5) % (pi * 2),
                      accuracy: pi * 0.2,
                    );
                  }
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
