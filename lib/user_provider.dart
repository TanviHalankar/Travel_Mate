import 'package:flutter/material.dart';

import 'model/users.dart';

class UserProvider with ChangeNotifier {
  Users? _user;

  Users? get getUser => _user;

  // Define a method to update the user data
  void updateUser(Users newUser) {
    _user = newUser;
    notifyListeners();
  }
}
