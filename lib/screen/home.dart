import 'package:flutter/material.dart';
import 'package:kan_absen/colors/colour_template.dart';
import 'package:kan_absen/screen/scan_qr.dart';
import 'package:kan_absen/widgets/go_home_card.dart';
import 'package:kan_absen/widgets/info_card.dart';
import 'package:kan_absen/widgets/present_card.dart';
import 'package:kan_absen/widgets/warning_card.dart';

class Home extends StatelessWidget {
  const Home({ Key? key }) : super(key: key);
  static const route = "/home_screen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColourTemplate.whiteColour,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: const [
                      Text(
                        "Halo,",
                        style: TextStyle(
                          color: ColourTemplate.grayColour,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                        ),
                      ),
                      Text(
                        "Denis",
                        style: TextStyle(
                          color: ColourTemplate.grayColour,
                          fontWeight: FontWeight.w500,
                          fontSize: 20
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(36)),
                      child: Image(image: AssetImage("assets/images/IMG-20190903-WA0008.jpeg"), fit: BoxFit.cover,),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16,),
            const WarningCard(),
            const GoHomeCard(),
            const PresentCard(),
            const InfoCard(),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
              decoration: const BoxDecoration(
                color: ColourTemplate.primaryColour,
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(ScanQR.route);
                  },
                  splashColor: Colors.black.withOpacity(.1),
                  highlightColor: Colors.black.withOpacity(.1),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                    child: const Text(
                      "Scan Untuk Absen",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}