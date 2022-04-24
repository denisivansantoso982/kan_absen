import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:kan_absen/models/data/agenda_data.dart';

class AgendaModel extends ChangeNotifier {
  final List<AgendaData> listOfAgenda = [];

  UnmodifiableListView<AgendaData> get theListOfAgenda =>
      UnmodifiableListView(listOfAgenda);

  void fillAgenda(AgendaData agenda) {
    listOfAgenda.add(agenda);
    notifyListeners();
  }

  void clearAgenda() {
    listOfAgenda.clear();
    notifyListeners();
  }
}
