import 'package:flutter/material.dart';
import 'package:kan_absen/colors/colour_template.dart';

class GoHomeCard extends StatelessWidget {
  const GoHomeCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(79, 205, 34, 1),
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black.withOpacity(.25),
            offset: const Offset(2, 4),
            spreadRadius: 1
          )
        ]
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: const Icon(
                    Icons.check_circle_outline_rounded,
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
                  children: const [
                    Text(
                      "Sampai Jumpa!",
                      style: TextStyle(
                        color: ColourTemplate.grayColour,
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),
                    ),
                    SizedBox(height: 8,),
                    Text(
                      "Sampai jumpa dihari berikutnya!",
                      style: TextStyle(
                        color: ColourTemplate.grayColour,
                        fontWeight: FontWeight.w500,
                        fontSize: 14
                      ),
                    ),
                    SizedBox(height: 20,),
                  ],
                )
              ),
            ],
          ),
          const SizedBox(height: 4,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "8:00",
                  style: TextStyle(
                    color: ColourTemplate.grayColour,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "17:00",
                  style: TextStyle(
                    color: ColourTemplate.grayColour,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }
}