import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kan_absen/models/profile_model.dart';
import 'package:kan_absen/screen/profile_screen.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/scan_qr_screen.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:kan_absen/screen/home_screen.dart';
import 'package:kan_absen/screen/login_screen.dart';
import 'package:kan_absen/screen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ProfileModel()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'KanAbsen',
        theme: ThemeData(
          primaryColor: ColourTemplate.primaryColour,
          fontFamily: 'Ubuntu',
          colorScheme: ColorScheme.fromSwatch()
              .copyWith(secondary: ColourTemplate.primaryColour),
        ),
        routes: {
          SplashScreen.route: (context) => const SplashScreen(),
          LoginScreen.route: (context) => const LoginScreen(),
          HomeScreen.route: (context) => const HomeScreen(),
          ScanQRScreen.route: (context) => const ScanQRScreen(),
          ProfileScreen.route: (context) => const ProfileScreen(),
        },
        initialRoute: SplashScreen.route,
      ),
    );
  }
}
