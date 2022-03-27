import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kan_absen/templates/colour_template.dart';
import 'package:kan_absen/templates/text_style_template.dart';
import 'package:kan_absen/widgets/card_menu_widget.dart';

class PresentCard extends StatelessWidget {
  const PresentCard({Key? key, required this.presentTime}) : super(key: key);
  final DateTime presentTime;

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
                    alignment: Alignment.center,
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
              )),
          const SizedBox(
            width: 16,
          ),
          Expanded(
              flex: 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Mantap!",
                    style: TextStyleTemplate.boldGray(size: 18),
                  ),
                  Text("Absen lagi untuk pulang!",
                      style: TextStyleTemplate.mediumGray(size: 14)),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}
