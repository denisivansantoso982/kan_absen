import 'package:flutter/material.dart';

class CardMenuWidget extends StatelessWidget {
  const CardMenuWidget({Key? key, required this.child, required this.startColour, required this.endColour}) : super(key: key);
  final Widget child;
  final Color startColour;
  final Color endColour;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      padding: const EdgeInsets.all(16),
      height: 155,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(48),
          bottomLeft: Radius.circular(48),
          bottomRight: Radius.circular(8),
        ),
        gradient: LinearGradient(
          begin: const Alignment(.2, 1),
          end: const Alignment(.8, 0),
          colors: [
            startColour,
            endColour,
          ],
        ),
      ),
      child: child,
    );
  }
}
