import 'package:flutter/material.dart';

class WarningCard extends StatelessWidget {
  const WarningCard({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(233, 197, 7, 1),
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
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.topCenter,
              child: const Icon(
                Icons.warning_amber_rounded,
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
                  "Perhatian!",
                  style: TextStyle(
                    color: Color.fromRGBO(51, 51, 51, 1),
                    fontWeight: FontWeight.bold,
                    fontSize: 18
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  "Anda belum absen hari ini! Harap absen tepat waktu!",
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