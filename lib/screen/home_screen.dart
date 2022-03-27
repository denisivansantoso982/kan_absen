import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/firebase/auth.dart';
import 'package:kan_absen/firebase/database.dart';
import 'package:kan_absen/models/data/present_data.dart';
import 'package:kan_absen/models/present_model.dart';
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
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static const route = "/home_screen";
  static final DateTime today = DateTime.now();

  void _doLoadProfile(BuildContext context) async {
    try {
      User? user = await getCurrentUser();
      if (user != null) {
        await getUserByEmail(user.email, context);
        await Future.delayed(const Duration(seconds: 1));
        _doLoadDataPresent(context);
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

  void _doLoadDataPresent(BuildContext context) async {
    try {
      await getUserPresent(context);
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

  void _doProcessBeforeScan(BuildContext context) {
    DateTime presentTime = DateTime(today.year, today.month, today.day, 8);
    DateTime homeTime =   DateTime(today.year, today.month, today.day, DateTime.now().weekday != DateTime.saturday ? 17 : 16);
    PresentData? presentData =
        Provider.of<PresentModel>(context, listen: false).thePresentData;
    if (presentData == null) {
      Navigator.of(context).pushNamed(
        ScanQRScreen.route,
        arguments: {
          'present_time': presentTime,
          'home_time': homeTime,
        },
      );
    } else if (presentData.home == 0 && DateTime.now().isAfter(homeTime)) {
      Navigator.of(context).pushNamed(
        ScanQRScreen.route,
        arguments: {
          'present_time': presentTime,
          'home_time': homeTime,
        },
      );
    } else if (presentData.present != 0 && presentData.home == 0 && DateTime.now().isBefore(homeTime)) {
      AlertDialogTemplate().showTheDialog(
        context: context,
        title: 'Informasi!',
        content: 'Sudah absen! Tunggu pulang nanti untuk absen!',
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
    } else if (presentData.present != 0 && presentData.home != 0 && DateTime.now().isAfter(homeTime)) {
      AlertDialogTemplate().showTheDialog(
        context: context,
        title: 'Informasi!',
        content: 'Sudah absen! Tunggu hari kerja selanjutnya untuk absen!',
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

  List<Widget> _doGenerateCard(BuildContext context, PresentModel present) {
    PresentData? presentData =
        Provider.of<PresentModel>(context, listen: false).thePresentData;
    if (present.thePresentData != null) {
      if (present.thePresentData!.present == 0) {
        return <Widget>[
          const WarningCard(),
          const InfoCard(),
        ];
      } else if (present.thePresentData!.home == 0) {
        return <Widget>[
          PresentCard(presentTime: DateTime.fromMillisecondsSinceEpoch(presentData!.present),),
          const InfoCard(),
        ];
      } else {
        return <Widget>[
          GoHomeCard(
            presentTime: DateTime.fromMillisecondsSinceEpoch(presentData!.present),
            homeTime: DateTime.fromMillisecondsSinceEpoch(presentData.home),
          ),
          const InfoCard(),
        ];
      }
    }
    return <Widget>[
      const WarningCard(),
      const InfoCard(),
    ];
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 8.0, bottom: 4),
        child: Consumer<PresentModel>(
          builder: (context, present, child) {
            return Column(
              children: _doGenerateCard(context, present),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: MaterialButton(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onPressed: () => _doProcessBeforeScan(context),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
              color: ColourTemplate.primaryColour,
              borderRadius: BorderRadius.all(Radius.circular(8))),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.qr_code_scanner_outlined,
                color: Colors.white,
                size: 28,
              ),
              const SizedBox(width: 8),
              Text(
                "Scan",
                style: TextStyleTemplate.boldWhite(size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
