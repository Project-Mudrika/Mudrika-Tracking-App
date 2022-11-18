import 'package:flutter/material.dart';
import 'package:live_tracking/constants/user_type.dart';
import 'package:live_tracking/screens/map_page.dart';

class ConsignmentSelect extends StatelessWidget {
  ConsignmentSelect({Key? key}) : super(key: key);

  final driverIDs = ['driver1', 'driver2', 'driver3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(18.0),
      child: ListView.builder(
          itemCount: driverIDs.length,
          itemBuilder: ((context, index) => ListTile(
                title: Text(driverIDs[index]),
                onTap: (() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MapPage(
                                userType: UserType.driver,
                                driverId: driverIDs[index],
                              )));
                }),
              ))),
    ));
  }
}
