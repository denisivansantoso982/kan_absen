import 'package:flutter/foundation.dart';
import 'package:kan_absen/models/data/present_data.dart';

class PresentModel extends ChangeNotifier {
  PresentData? presentData;

  PresentData? get thePresentData => presentData;

  void fillPresent(PresentData data) {
    presentData = data;
    notifyListeners();
  }

  void removePresent() {
    presentData = null;
    notifyListeners();
  }
}
