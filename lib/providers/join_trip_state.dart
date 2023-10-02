import 'package:flutter/material.dart';

class JoinTripState extends ChangeNotifier {
  Map<int, bool> _requestStatusMap = {};

  bool getRequestStatus(int tripId) {
    return _requestStatusMap[tripId] ?? false;
  }

  void updateRequestStatus(int tripId, bool newStatus) {
    _requestStatusMap[tripId] = newStatus;
    notifyListeners();
  }
}
