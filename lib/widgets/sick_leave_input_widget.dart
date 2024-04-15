import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class SickLeaveInputWidget extends StatelessWidget {
  final String text;
  final String? imagePath;
  final TextInputType type;
  const SickLeaveInputWidget({super.key, required this.text, this.imagePath, required this.type});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        keyboardType: type,
        decoration: InputDecoration(
          suffixIcon: imagePath != null ? Image.asset(imagePath!) : null,
          labelText: text,
          labelStyle: GoogleFonts.roboto(
            fontSize: 15,
            color: const Color(0xff8F9BB3),
          ),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
              borderSide: const BorderSide(
                color: Color(0xffEDF1F7),
                width: 1,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: const BorderSide(
              color: Color(0xffEDF1F7),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
