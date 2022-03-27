import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:kan_absen/widgets/card_menu_widget.dart';

class GoHomeCard extends StatelessWidget {
  const GoHomeCard({ Key? key, required this.presentTime, required this.homeTime }) : super(key: key);
  final DateTime presentTime;
  final DateTime homeTime;

  @override
  Widget build(BuildContext context) {
    return CardMenuWidget(
      startColour: ColourTemplate.leafColour,
      endColour: ColourTemplate.leafColour.withOpacity(.8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(),
                Container(
                  alignment: Alignment.topCenter,
                  child: const Icon(
                    Icons.check_circle_outline_rounded,
                    color: ColourTemplate.grayColour,
                    size: 64,
                  ),
                ),
                Text(
                  DateFormat('HH:mm').format(presentTime),
                  style: TextStyleTemplate.mediumGray(size: 12),
                ),
              ],
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
                  "Sampai Jumpa!",
                  style: TextStyleTemplate.boldGray(size: 18),
                ),
                const SizedBox(height: 8,),
                Text(
                  "Sampai jumpa dihari berikutnya!",
                  style: TextStyleTemplate.mediumGray(size: 14),
                ),
                const SizedBox(height: 8,),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 8),
                  child: Text(
                    DateFormat('HH:mm').format(homeTime),
                    style: TextStyleTemplate.mediumGray(size: 12),
                  ),
                ),
              ],
            )
          ),
        ],
      ),
    );
  }
}