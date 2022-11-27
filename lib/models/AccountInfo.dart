import 'dart:collection';
import 'package:flutter/foundation.dart';

class AccountInfo extends ChangeNotifier {
  Map<String, String> _accountInfo = {
    "accountAddress": "",
    "accountType": "",
    "accessLevel": "",
    "firstName": "",
    "lastName": "",
    "state": "",
    "district": "",
    "mobileNumber": "",
  };

  UnmodifiableMapView<String, String> get accountInfo =>
      UnmodifiableMapView(_accountInfo);

  void updateAccountField(String key, String value) {
    _accountInfo[key] = value;

    notifyListeners();
  }

  void updateAccountInfo(Map<String, String> newAccountInfo) {
    if (_accountInfo.keys == newAccountInfo.keys) {
      _accountInfo = newAccountInfo;

      notifyListeners();
    } else {
      debugPrint("""
    AccountInfo Map should be in the format: 
    {
    "accountAddress": "",
    "accountType": "",
    "accessLevel": "",
    "firstName": "",
    "lastName": "",
    "state": "",
    "district": "",
    "mobileNumber": "",
    }
""");
    }
  }
}
