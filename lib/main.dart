import 'package:flutter/material.dart';
import 'package:live_tracking/screens/map_page.dart';
import 'package:live_tracking/services/location_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final location = LocationService();

  @override
  void initState() {
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
          child: Scaffold(
            body: FutureBuilder(
              future: location.determinePosition(),
              builder: (_, currLocation) {
                if (currLocation.hasData) {
                  return MapPage(
                    latitude: currLocation.data?.latitude ?? 28.644800,
                    longitude: currLocation.data?.longitude ?? 77.216721,
                  );
                } else {
                  return const SizedBox(
                    height: 500,
                    width: 500,
                    child: Center(
                        child: Text("Location Loading",
                            style: TextStyle(fontSize: 20))),
                  );
                }
              },
            ),
          ),
        ));
  }
}
