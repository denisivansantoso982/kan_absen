import 'package:flutter/material.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:kan_absen/widgets/card_menu_widget.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CardMenuWidget(
      startColour: ColourTemplate.orangeColour,
      endColour: ColourTemplate.orangeColour.withOpacity(.8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.center,
              child: const Icon(
                Icons.warning_amber_rounded,
                color: ColourTemplate.grayColour,
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
              children: [
                Text(
                  "Perhatian!",
                  style: TextStyleTemplate.boldGray(size: 18),
                ),
                Text(
                  "Anda belum absen hari ini! Harap absen tepat waktu!",
                  style: TextStyleTemplate.mediumGray(size: 14),
                ),
                const SizedBox(height: 20,),
              ],
            )
          ),
        ],
      )
    );
  }
}