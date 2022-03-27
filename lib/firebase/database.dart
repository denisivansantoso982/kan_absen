import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:kan_absen/models/data/present_data.dart';
import 'package:kan_absen/models/data/users_data.dart';
import 'package:kan_absen/models/present_model.dart';
import 'package:kan_absen/models/profile_model.dart';
import 'package:provider/provider.dart';

DatabaseReference usersReference = FirebaseDatabase.instance.ref('users');
DatabaseReference presentReference = FirebaseDatabase.instance.ref('present');

Future<void> getUserByEmail(String? email, BuildContext context) async {
  usersReference.orderByChild('email').equalTo(email).onValue.listen((event) {
    if (event.snapshot.exists) {
      DataSnapshot dataSnapshot = event.snapshot;
      Provider.of<ProfileModel>(context, listen: false).fillProfile(
        UsersData(
          uid: dataSnapshot.children.first.key.toString(),
          name: dataSnapshot.children.first.child('name').value.toString(),
          dateOfBirth: DateTime.fromMillisecondsSinceEpoch(int.parse(
              dataSnapshot.children.first
                  .child('date_of_birth')
                  .value
                  .toString())),
          sex: dataSnapshot.children.first.child('sex').value.toString(),
          email: dataSnapshot.children.first.child('email').value.toString(),
          role: dataSnapshot.children.first.child('level').value.toString(),
          quotes: dataSnapshot.children.first.child('quotes').value.toString(),
        ),
      );
    }
  }).onError((error) => Future.error(error));
}

Future<void> getUserPresent(BuildContext context) async {
  String usersUid =
      Provider.of<ProfileModel>(context, listen: false).theProfile!.uid;
  DateTime today = DateTime.now();
  int todayTimeStamp = DateTime(today.year, today.month, today.day, 0, 0, 0).millisecondsSinceEpoch;
  presentReference.orderByChild('present_time').endAt(todayTimeStamp, key: 'present_time').onValue.listen((event) {
    if (event.snapshot.exists) {
      for (var element in event.snapshot.children) {
        if (element.child('users').value.toString() == usersUid) {
          Provider.of<PresentModel>(context, listen: false).fillPresent(
            PresentData(
              uid: element.key.toString(),
              users: element.child('users').value.toString(),
              present: int.parse(element.child('present_at').value.toString()),
              home: element.child('home_at').value != null
                ? int.parse(element.child('home_at').value.toString())
                : 0,
            ),
          );
          break;
        }
      }
    } else {
      Provider.of<PresentModel>(context, listen: false).removePresent();
    }
  }).onError((error, stackTrace) => Future.error(error, stackTrace));
}

Future<bool> checkUserByEmail(String? email) async {
  bool isExist = false;
  final DataSnapshot dataSnapshot = await usersReference
      .orderByChild('email')
      .equalTo(email)
      .get()
      .onError((error, stackTrace) => Future.error(error!, stackTrace));
  if (dataSnapshot.exists) {
    isExist = true;
  }

  return isExist;
}

Future<void> doScanPresent(String usersUid, int presentTime) async {
  await presentReference.push().set({
    'users': usersUid,
    'present_at': presentTime,
  }).onError((error, stackTrace) => Future.error(error!, stackTrace));
}

Future<void> doScanHome(
    String? uid, String usersUid, int presentTime, int homeTime) async {
  if (uid == null) {
    await presentReference.push().set({
      'users': usersUid,
      'home_at': homeTime,
    }).onError((error, stackTrace) => Future.error(error!, stackTrace));
  } else {
    await presentReference.child(uid).set({
      'users': usersUid,
      'present_at': presentTime,
      'home_at': homeTime,
    }).onError((error, stackTrace) => Future.error(error!, stackTrace));
  }
}
