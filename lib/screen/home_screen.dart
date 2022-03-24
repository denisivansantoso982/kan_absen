import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/firebase/auth.dart';
import 'package:kan_absen/firebase/database.dart';
import 'package:kan_absen/screen/login_screen.dart';
import 'package:kan_absen/screen/profile_screen.dart';
import 'package:kan_absen/templates/alert_dialog_template.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/scan_qr_screen.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:kan_absen/widgets/appbar_widget.dart';
import 'package:kan_absen/widgets/go_home_card.dart';
import 'package:kan_absen/widgets/info_card.dart';
import 'package:kan_absen/widgets/present_card.dart';
import 'package:kan_absen/widgets/warning_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "/home_screen";
  static final DateTime today = DateTime.now();

  void _doLoadProfile(BuildContext context) async {
    try {
      User? user = await getCurrentUser();
      if (user != null) {
        getUserByEmail(user.email, context);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginScreen.route);
      }
    } catch (error) {
      AlertDialogTemplate().showTheDialog(
        context: context,
        title: "Terjadi Kesalahan!",
        content: error.toString(),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            color: ColourTemplate.primaryColour,
            child: Text(
              "OKE",
              style: TextStyleTemplate.boldWhite(size: 18),
            ),
          ),
        ],
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    _doLoadProfile(context);
    return Scaffold(
      backgroundColor: ColourTemplate.whiteColour,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(72),
        child: AppBarWidget(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                DateFormat('dd').format(today),
                style: const TextStyle(
                  fontSize: 32,
                  color: ColourTemplate.grayColour,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 4,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('MMMM').format(today),
                    style: const TextStyle(
                      color: ColourTemplate.primaryColour,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateFormat('yyyy').format(today),
                    style: const TextStyle(
                      color: ColourTemplate.grayColour,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: Container(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () =>
                        Navigator.of(context).pushNamed(ProfileScreen.route),
                    child: const SizedBox(
                      width: 45,
                      height: 45,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(48)),
                        child: Image(
                          image: AssetImage(
                              "assets/images/IMG-20190903-WA0008.jpeg"),
                          width: 45,
                          height: 45,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const WarningCard(),
              const GoHomeCard(),
              const PresentCard(),
              const InfoCard(),
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                decoration: const BoxDecoration(
                  color: ColourTemplate.primaryColour,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed(ScanQRScreen.route);
                    },
                    splashColor: Colors.black.withOpacity(.1),
                    highlightColor: Colors.black.withOpacity(.1),
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: const Text(
                        "Scan Untuk Absen",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
