import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DaysWidget extends StatelessWidget {
  final String text;
  final String subText;
  final Color color;
  const DaysWidget(
      {super.key,
      required this.text,
      required this.subText,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: const Color(0xff8A8F9B),
              ),
            ),
          ],
        ),
        Text(
          subText,
          style: GoogleFonts.roboto(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: color,
          ),
        )
      ],
    );
  }
}
