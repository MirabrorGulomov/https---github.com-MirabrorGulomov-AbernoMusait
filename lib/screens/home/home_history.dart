import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';
import 'package:musait/widgets/calendar.dart';
import 'package:musait/widgets/last_week_widget.dart';
import 'package:musait/widgets/progress_widget.dart';
import 'package:musait/widgets/this_week_widget.dart';

class HomeHistory extends StatefulWidget {
  const HomeHistory({Key? key}) : super(key: key);

  @override
  State<HomeHistory> createState() => _HomeHistoryState();
}

class _HomeHistoryState extends State<HomeHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Material(
                    elevation: 5,
                    shadowColor: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      // width: double.infinity,
                      height: 51.h,
                      child: TabBar(
                        splashBorderRadius: BorderRadius.circular(20.r),
                        indicator: BoxDecoration(
                          color: Color(0xff007AFF),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        unselectedLabelColor: const Color(0xff8A8F9B),
                        labelColor: Colors.white,
                        indicatorSize: TabBarIndicatorSize.tab,
                        labelStyle: GoogleFonts.roboto(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize: 13,
                        ),
                        tabs: [
                          Container(
                            width: 155.w,
                            height: 41.h,
                            child: Image.asset(
                              "assets/images/Icon.png",
                              // color: Colors.white,
                            ),
                          ), // First tab
                          Container(
                            width: 155.w,
                            height: 41.h,
                            child: const Tab(
                              text: 'Эта неделя',
                            ),
                          ),
                          Container(
                            width: 155.w,
                            height: 41.h,
                            child: const Tab(
                              text: 'Прошлая неделя',
                            ),
                          ), // Second tab
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 330.h, // Adjust this value as needed
                    child: const TabBarView(
                      children: [
                        CalendarWidget(),
                        ThisWeekWidget(),
                        LastWeekWidget(),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
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
              ),
            ),
          ),
        ),
      ),
    );
  }
}
