import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:kan_absen/models/data/users_data.dart';
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

Future<bool> checkUserByEmail(String? email) async {
  bool isExist = false;
  final DataSnapshot dataSnapshot =
      await usersReference.orderByChild('email').equalTo(email).get();
  if (dataSnapshot.exists) {
    isExist = true;
  }

  return isExist;
}
