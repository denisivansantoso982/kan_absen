import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:kan_absen/firebase/auth.dart';
import 'package:kan_absen/firebase/database.dart';
import 'package:kan_absen/models/data/users_data.dart';
import 'package:kan_absen/models/profile_model.dart';
import 'package:kan_absen/screen/home_screen.dart';
import 'package:kan_absen/templates/alert_dialog_template.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/login_screen.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const route = "/splash_screen";

  void _checkAuthIsExist(BuildContext context) async {
    try {
      User? user = await getCurrentUser();
      if (user != null) {
        DataSnapshot? dataSnapshot = await getUserByEmail(user.email);
        if (dataSnapshot != null) {
          Provider.of<ProfileModel>(context, listen: false).fillProfile(
            UsersData(
              uid: dataSnapshot.children.first.key.toString(),
              name: dataSnapshot.children.first.child('name').value.toString(),
              dateOfBirth: DateTime.fromMillisecondsSinceEpoch(int.parse(dataSnapshot.children.first.child('date_of_birth').value.toString())),
              sex: dataSnapshot.children.first.child('sex').value.toString(),
              email: dataSnapshot.children.first.child('email').value.toString(),
              role: dataSnapshot.children.first.child('level').value.toString(),
              quotes: dataSnapshot.children.first.child('quotes').value.toString(),
            ),
          );
        } else {
          user = null;
        }
      }
      Navigator.of(context).pushReplacementNamed(
          user != null ? HomeScreen.route : LoginScreen.route);
    } catch (error) {
      AlertDialogTemplate().showTheDialog(
        context: context,
        title: "Terjadi Kesalahan!",
        content: error.toString(),
        actions: [
          MaterialButton(
            child: Text(
              "OK",
              style: TextStyleTemplate.mediumWhite(size: 16),
            ),
            onPressed: () => Navigator.of(context).pop(),
            color: ColourTemplate.primaryColour,
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkAuthIsExist(context);
    return Container(
      color: ColourTemplate.whiteColour,
      alignment: Alignment.center,
      child: const Text(
        "KanAbsen",
        style: TextStyle(
            color: ColourTemplate.primaryColour,
            fontSize: 48,
            fontFamily: "Ubuntu",
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.none),
      ),
    );
  }
}
