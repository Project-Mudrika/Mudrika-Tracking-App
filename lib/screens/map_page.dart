import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:live_tracking/services/location_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapPage extends StatefulWidget {
  MapPage({super.key, required this.latitude, required this.longitude});
  final double latitude, longitude;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final _mapController = MapTileLayerController();

  @override
  Widget build(BuildContext context) {
    var movlat = widget.latitude;
    var movlong = widget.longitude;
    return Stack(
      children: [
        SfMaps(
          layers: [
            MapTileLayer(
              zoomPanBehavior: MapZoomPanBehavior(
                enablePanning: true,
                enableDoubleTapZooming: true,
                enablePinching: true,
                enableMouseWheelZooming: true,
              ),
              initialMarkersCount: 1,
              urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
              initialZoomLevel: 15,
              initialFocalLatLng: MapLatLng(widget.latitude, widget.longitude),
              controller: _mapController,
              markerBuilder: (BuildContext context, int index) {
                return MapMarker(
                  size: const Size(14, 14),
                  iconColor: Colors.black,
                  latitude: movlat,
                  longitude: movlong,
                );
              },
            ),
          ],
        ),
        Column(
          children: [
            FloatingActionButton(
              child: Text('Add marker'),
              onPressed: () {
                _mapController.insertMarker(0);
              },
            ),
            FloatingActionButton(
              child: Text('Update marker'),
              onPressed: () async {
                movlat += 0.0001;
                movlong += 0.0001;
                _mapController.updateMarkers([0]);
                // final locationService = LocationService();
                // var loc = await locationService.determinePosition();
                // print("Lat: ${loc.latitude}");
              },
            ),
          ],
        )
      ],
    );
  }
}
