import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kan_absen/firebase/auth.dart';
import 'package:kan_absen/firebase/database.dart';
import 'package:kan_absen/models/data/users_data.dart';
import 'package:kan_absen/models/profile_model.dart';
import 'package:kan_absen/templates/alert_dialog_template.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/home_screen.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const route = "/login_screen";

  void _doLoginProcess(BuildContext context) async {
    try {
      showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()),
        barrierDismissible: false,
      );
      GoogleSignInAccount? googleUser = await signInWithGoogle();
      if (googleUser != null) {
        DataSnapshot? dataSnapshot = await getUserByEmail(googleUser.email);
        if (dataSnapshot != null) {
          await authenticationEmail(googleUser);
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
              email:
                  dataSnapshot.children.first.child('email').value.toString(),
              role: dataSnapshot.children.first.child('level').value.toString(),
              quotes:
                  dataSnapshot.children.first.child('quotes').value.toString(),
            ),
          );
          bool isStored = Provider.of<ProfileModel>(context, listen: false)
                      .theProfile!
                      .uid ==
                  ''
              ? false
              : true;
          Navigator.of(context).pop();
          if (isStored) {
            Navigator.of(context).pushReplacementNamed(HomeScreen.route);
          }
        } else {
          Navigator.of(context).pop();
          await signOut();
          throw Exception('Pengguna tidak ditemukan');
        }
      }
    } on PlatformException catch (error) {
      print(error);
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
    return Scaffold(
      backgroundColor: ColourTemplate.whiteColour,
      body: Column(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Login",
                  style: TextStyle(
                      color: ColourTemplate.primaryColour,
                      fontSize: 48,
                      decoration: TextDecoration.none,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  "Loginnya pakai Google ya!!!",
                  style: TextStyle(
                      color: ColourTemplate.primaryColour,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: MaterialButton(
                onPressed: () => _doLoginProcess(context),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 4,
                            offset: const Offset(2, 4)),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Image(
                          image:
                              AssetImage("assets/images/Google__G__Logo.png"),
                          width: 30),
                      SizedBox(
                        width: 16,
                      ),
                      Text(
                        "Login dengan Google",
                        style: TextStyle(
                            color: Color.fromRGBO(53, 53, 53, 1),
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: Container())
        ],
      ),
    );
  }
}
