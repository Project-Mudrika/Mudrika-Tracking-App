import 'dart:collection';

import 'package:flutter/foundation.dart';

class Consignment extends ChangeNotifier {
  Map<String, String> _consignment = {
    "cons_id": "",
    "con_name": "",
    "quantity": "",
    "location": "",
    "sender": "",
    "curr_holder": "",
    "receiver": ""
  };

  UnmodifiableMapView<String, String> get consignment =>
      UnmodifiableMapView(_consignment);

  void updateConsignmentField(String key, String value) {
    _consignment[key] = value;

    notifyListeners();
  }

  void updateConsignmentInfo(Map<String, String> newConsignmentDetails) {
    if (_consignment.keys == newConsignmentDetails.keys) {
      _consignment = newConsignmentDetails;

      notifyListeners();
    } else {
      debugPrint("""
    Consignment Map should be in the format: 
    {
    "cons_id": "",
    "con_name": "",
    "quantity": "",
    "location": "",
    "sender": "",
    "curr_holder": "",
    "receiver": ""
    }
""");
    }
  }
}
