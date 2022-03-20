import 'package:flutter/material.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/screen/home.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);
  static const route = "/login_screen";

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
                    fontWeight: FontWeight.bold
                  ),
                ),
                SizedBox(height: 16,),
                Text(
                  "Loginnya pakai Google ya!!!",
                  style: TextStyle(
                    color: ColourTemplate.primaryColour,
                    fontSize: 16,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: MaterialButton(
                onPressed: () => Navigator.pushNamed(context, Home.route),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 4,
                        offset: const Offset(2, 4)
                      ),
                    ],
                    borderRadius: const BorderRadius.all(Radius.circular(4))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Image(image: AssetImage("assets/images/Google__G__Logo.png"), width: 30),
                      SizedBox(width: 16,),
                      Text(
                        "Login dengan Google",
                        style: TextStyle(
                          color: Color.fromRGBO(53, 53, 53, 1),
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
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
