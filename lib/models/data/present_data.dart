class PresentData {
  PresentData({
    required this.uid,
    required this.users,
    this.present = 0,
    this.home = 0
  });

  String uid;
  String users;
  int present;
  int home;
}
