import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:live_tracking/constants/user_type.dart';
import 'package:live_tracking/services/location_service.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

class MapPage extends StatefulWidget {
  final UserType userType;
  final driverId;
  MapPage({super.key, required this.userType, this.driverId = 'driver1'});
  final LocationService _locationService = LocationService();
  final _mapController = MapTileLayerController();
  final _mapZoomPanController = MapZoomPanBehavior();

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late Position currLocation;

  @override
  void initState() {
    var currLocationStream = LocationService();

    if (widget.userType == UserType.driver) {
      currLocationStream.livePosition().listen((Position newPostion) {
        currLocation = newPostion;
        print("whyy");
        widget._mapController.updateMarkers([0]);
        widget._mapZoomPanController.focalLatLng =
            MapLatLng(currLocation.latitude, currLocation.longitude);
      });
    } else if (widget.userType == UserType.authority) {
      currLocationStream
          .receiveLocationUpdates(widget.driverId)
          .listen((Position newPostion) {
        currLocation = newPostion;
        print("works here");
        print("${currLocation.latitude} ${currLocation.longitude}");
        widget._mapController.updateMarkers([0]);
        widget._mapZoomPanController.focalLatLng =
            MapLatLng(currLocation.latitude, currLocation.longitude);
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // currLocation = Position(
    //     longitude: 0,
    //     latitude: 0,
    //     timestamp: null,
    //     accuracy: 0,
    //     altitude: 0,
    //     heading: 0,
    //     speed: 0,
    //     speedAccuracy: 0);
    return Scaffold(
      body: FutureBuilder(
          future: widget.userType == UserType.driver
              ? widget._locationService.determinePosition()
              : widget._locationService.receiveInitialLocation(widget.driverId),
          builder: (_, initLocationSnapshot) {
            if (initLocationSnapshot.hasData) {
              currLocation = initLocationSnapshot.data!;
              print("hello ${initLocationSnapshot.data!.latitude}");
              print("hello ${initLocationSnapshot.data!.longitude}");
              return Stack(
                children: [
                  SfMaps(
                    layers: [
                      MapTileLayer(
                        zoomPanBehavior: widget._mapZoomPanController,
                        initialMarkersCount: 1,
                        urlTemplate:
                            "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                        initialZoomLevel: 15,
                        initialFocalLatLng: MapLatLng(
                            initLocationSnapshot.data!.latitude,
                            initLocationSnapshot.data!.longitude),
                        controller: widget._mapController,
                        markerBuilder: (BuildContext context, int index) {
                          return MapMarker(
                            size: const Size(22, 22),
                            iconColor: Colors.black87,
                            latitude: currLocation.latitude,
                            longitude: currLocation.longitude,
                          );
                        },
                      ),
                    ],
                  ),
                  Positioned(
                    right: 10,
                    bottom: 10,
                    child: Row(
                      children: [
                        FloatingActionButton(
                          child: const Icon(Icons.add),
                          onPressed: () {
                            if (widget._mapZoomPanController.zoomLevel <
                                widget._mapZoomPanController.maxZoomLevel) {
                              widget._mapZoomPanController.zoomLevel += 1;
                            }
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        FloatingActionButton(
                          child: const Icon(Icons.remove),
                          onPressed: () {
                            if (widget._mapZoomPanController.zoomLevel >
                                widget._mapZoomPanController.minZoomLevel) {
                              widget._mapZoomPanController.zoomLevel -= 1;
                            }
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            } else {
              return const SizedBox(
                height: 500,
                width: 500,
                child: Center(
                    child: Text("Live Tracking Loading",
                        style: TextStyle(fontSize: 20))),
              );
            }
          }),
    );
  }
}
