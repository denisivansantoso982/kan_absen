import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kan_absen/colors/colour_template.dart';
import 'package:kan_absen/screen/scan_qr.dart';
import 'firebase_options.dart';
import 'package:kan_absen/screen/home.dart';
import 'package:kan_absen/screen/login.dart';
import 'package:kan_absen/screen/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'KanAbsen',
      theme: ThemeData(
        primaryColor: ColourTemplate.primaryColour,
        fontFamily: 'Ubuntu',
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: ColourTemplate.primaryColour),
      ),
      routes: {
        Splash.route: (context) => const Splash(),
        Login.route: (context) => const Login(),
        Home.route: (context) => const Home(),
        ScanQR.route: (context) => const ScanQR(),
      },
      initialRoute: Splash.route,
    );
  }
}
