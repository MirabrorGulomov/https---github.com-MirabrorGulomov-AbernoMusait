import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InputWidget extends StatelessWidget {
  final String text;
  final String label;
  final TextInputType type;
  final IconData? icon;
  final String? Function(String?)? validator;
  final bool obscure;
  final void Function()? onTap;
  final TextEditingController controller;
  const InputWidget({
    super.key,
    required this.text,
    required this.label,
    required this.type,
    this.icon,
    required this.validator,
    required this.obscure,
    this.onTap,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.w),
            child: Text(
              label,
              style: GoogleFonts.raleway(
                fontSize: 16,
              ),
            ),
          ),
          SizedBox(
            height: 14.h,
          ),
          TextFormField(
            controller: controller,
            validator: validator,
            keyboardType: type,
            obscureText: obscure,
            decoration: InputDecoration(
              suffixIcon: GestureDetector(
                child: Icon(icon),
                onTap: onTap,
              ),
              contentPadding: EdgeInsets.all(16),
              labelStyle: const TextStyle(
                color: Color(0xff6A6A6A),
              ),
              labelText: text,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: const BorderSide(color: Color(0xffF7F7F9)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14.r),
                borderSide: const BorderSide(color: Color(0xffF7F7F9)),
              ),
              fillColor: const Color(0xffF7F7F9),
              filled: true,
            ),
            autovalidateMode: AutovalidateMode.onUserInteraction,
          ),
        ],
      ),
    );
  }
}
