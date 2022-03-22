import 'package:firebase_database/firebase_database.dart';

DatabaseReference usersReference = FirebaseDatabase.instance.ref('users');
DatabaseReference presentReference = FirebaseDatabase.instance.ref('present');

Future<DataSnapshot?> getUserByEmail(String? email) async {
  final DataSnapshot dataSnapshot =
      await usersReference.orderByChild('email').equalTo(email).get();
  if (!dataSnapshot.exists) {
    return null;
  }

  return dataSnapshot;
}
