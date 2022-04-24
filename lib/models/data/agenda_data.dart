// ignore_for_file: non_constant_identifier_names

class AgendaData {
  AgendaData({
    required this.agenda_uid,
    required this.agenda_name,
    required this.agenda_detail,
    required this.agenda_start,
    required this.agenda_end,
    required this.isActive,
  });

  String agenda_uid;
  String agenda_name;
  String agenda_detail;
  DateTime agenda_start;
  DateTime agenda_end;
  bool isActive;
}