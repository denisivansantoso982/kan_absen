import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kan_absen/firebase/auth.dart';
import 'package:kan_absen/firebase/database.dart';
import 'package:kan_absen/screen/home_screen.dart';
import 'package:kan_absen/templates/alert_dialog_template.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/login_screen.dart';
import 'package:kan_absen/templates/text_style_template.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static const route = "/splash_screen";

  void _checkAuthIsExist(BuildContext context) async {
    try {
      User? user = await getCurrentUser();
      if (user != null) {
        bool isUserExist = await checkUserByEmail(user.email);
        if (!isUserExist) {
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
