import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:musait/widgets/days_widget.dart';
import 'package:musait/widgets/progress_widget.dart';

class LastWeekWidget extends StatelessWidget {
  const LastWeekWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Прогресс за прошлую неделю",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: const Color(0xff272727),
              ),
            ),
            Row(
              children: [
                Text(
                  "40",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    color: const Color(0xff0BAC00),
                  ),
                ),
                Text(
                  "/40ч",
                  style: GoogleFonts.roboto(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(
          height: 10.h,
        ),
        Container(
          height: 6.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6.r)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6.r),
            child: LinearProgressBar(
              maxSteps: 8,
              progressType:
                  LinearProgressBar.progressTypeLinear, // Use Linear progress
              currentStep: 8,
              progressColor: const Color(0xff0BAC00),
              backgroundColor: const Color(0xffD9D9D9),
            ),
          ),
        ),
        SizedBox(
          height: 10.h,
        ),
        const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DaysWidget(
                  text: "Пнд 16",
                  subText: "8",
                  color: Color(0xff0BAC00),
                ),
                DaysWidget(
                  text: "Вт 17",
                  subText: "8",
                  color: Color(0xff0BAC00),
                ),
                DaysWidget(
                  text: "Ср 18",
                  subText: "8",
                  color: Color(0xff0BAC00),
                ),
                DaysWidget(
                  text: "Чт 19",
                  subText: "8",
                  color: Color(0xff0BAC00),
                ),
                DaysWidget(
                  text: "Пт 20",
                  subText: "8",
                  color: Color(0xff9B9C9C),
                ),
                DaysWidget(
                  text: "Сб 21",
                  subText: "-",
                  color: Color(0xff9B9C9C),
                ),
                DaysWidget(
                  text: "Вск 22",
                  subText: "-",
                  color: Color(0xff9B9C9C),
                ),
              ],
            ),
          ],
        ),
        SizedBox(
          height: 15.h,
        ),
        const ProgressWidgetDart(
          borderColor: Color(0xff0BAC00),
          sideColor: Color(0xff0BAC00),
          circleColor: Color(0xffA9F2A4),
          circleTextColor: Color(0xff0BAC00),
          circleText: "08",
          text: "Пришел вовремя",
        ),
        SizedBox(
          height: 10.h,
        ),
        const ProgressWidgetDart(
          borderColor: Color(0xffE92020),
          sideColor: Color(0xffE92020),
          circleColor: Color(0xffFFB1B1),
          circleTextColor: Color(0xffE92020),
          circleText: "02",
          text: "Не пришел",
        ),
        SizedBox(
          height: 10.h,
        ),
        const ProgressWidgetDart(
          borderColor: Color(0xffFFB1B1),
          sideColor: Color(0xffFFB1B1),
          circleColor: Color(0xffFFB1B1),
          circleTextColor: Color(0xffE92020),
          circleText: "02",
          text: "Опоздал на работу",
        ),
        SizedBox(
          height: 10.h,
        ),
        const ProgressWidgetDart(
          borderColor: Color(0xff9BBFE5),
          sideColor: Color(0xff9BBFE5),
          circleColor: Color(0xff9BBFE5),
          circleTextColor: Color(0xff007AFF),
          circleText: "00",
          text: "Больничный",
        ),
      ],
    );
  }
}
