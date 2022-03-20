import 'package:flutter/material.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/widgets/card_menu_widget.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardMenuWidget(
      startColour: ColourTemplate.skyColour,
      endColour: ColourTemplate.skyColour.withOpacity(.8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              child: const Icon(
                Icons.info_outline_rounded,
                color: Color.fromRGBO(51, 51, 51, 1),
                size: 64,
              ),
            )
          ),
          const SizedBox(width: 16,),
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Info!",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "Masuk jam 8.00 \nPulang Jam 17.00",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontWeight: FontWeight.w500,
                    fontSize: 14
                  ),
                ),
                SizedBox(height: 20,),
              ],
            )
          ),
        ],
      )
    );
  }
}