import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/login.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);
  static const route = "/splash_screen";

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () => Navigator.pushReplacementNamed(context, Login.route));
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
          decoration: TextDecoration.none
        ),
      ),
    );
  }
}
