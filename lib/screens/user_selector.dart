import 'package:flutter/material.dart';
import 'package:live_tracking/constants/user_type.dart';
import 'package:live_tracking/screens/consignment_select_page.dart';
import 'package:live_tracking/screens/map_page.dart';

class UserSelector extends StatelessWidget {
  const UserSelector({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
            child: const Text("Driver"),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => MapPage(
                            userType: UserType.driver,
                          )));
            },
          ),
          MaterialButton(
            child: const Text("Authority"),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ConsignmentSelect()));
            },
          ),
        ],
      ),
    );
  }
}
