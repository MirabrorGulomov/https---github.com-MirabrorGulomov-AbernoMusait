import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ProgressWidgetDart extends StatelessWidget {
  final Color borderColor;
  final Color sideColor;
  final Color circleColor;
  final Color circleTextColor;
  final String text;
  final String circleText;
  const ProgressWidgetDart({
    super.key,
    required this.borderColor,
    required this.sideColor,
    required this.text,
    required this.circleColor,
    required this.circleText,
    required this.circleTextColor,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 47.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.r),
            border: Border.all(
              color: borderColor,
            ),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Container(
              width: 16.w,
              decoration: BoxDecoration(
                color: sideColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.r),
                  bottomLeft: Radius.circular(15.r),
                ),
              ),
            ),
            title: Container(
              // margin: EdgeInsets.only(left: 20.w),
              child: Text(
                text,
                style: GoogleFonts.roboto(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff272727),
                ),
              ),
            ),
            trailing: Container(
              margin: EdgeInsets.only(right: 10.w),
              width: 28.w,
              height: 28.h,
              decoration: BoxDecoration(
                color: circleColor,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Center(
                child: Text(
                  circleText,
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: circleTextColor,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
