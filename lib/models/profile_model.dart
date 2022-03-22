import 'package:flutter/foundation.dart';
import 'package:kan_absen/models/data/users_data.dart';

class ProfileModel extends ChangeNotifier {
  UsersData? profileData;

  UsersData? get theProfile => profileData;

  void fillProfile(UsersData user) {
    profileData = user;
    notifyListeners();
  }

  void removeAllProfile() {
    profileData = null;
    notifyListeners();
  }
}
