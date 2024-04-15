import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:musait/screens/home/home_attendance.dart';
import 'package:musait/screens/home/home_history.dart';
import 'package:musait/widgets/home_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting('ru');
    DateTime now = DateTime.now();
    String formattedDate =
        DateFormat('E, d MMMM', 'ru').format(now); // 'ru' for Russian locale
    formattedDate = formattedDate
        .replaceRange(0, 1,
            formattedDate[0].toUpperCase()) // Capitalize first letter of day
        .replaceRange(
            formattedDate.indexOf(' ') + 1,
            formattedDate.indexOf(' ') + 2,
            formattedDate[formattedDate.indexOf(' ') + 1]
                .toUpperCase()); // Capitalize first letter of month
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 20.h,
          ),
          child: DefaultTabController(
            length: 2,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const HomeIcons(image: "assets/images/category.png"),
                    Text(
                      formattedDate,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff002055),
                        fontSize: 18,
                      ),
                    ),
                    const HomeIcons(image: "assets/images/notifications.png"),
                  ],
                ),
                SizedBox(
                  height: 15.h,
                ),
                Text(
                  "Давайте проведем перекличку  🙌",
                  style: GoogleFonts.poppins(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff002055),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Material(
                  elevation: 5,
                  shadowColor: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10.r),
                  child: Container(
                    width: 320.w,
                    height: 51.h,
                    child: TabBar(
                      splashBorderRadius: BorderRadius.circular(20.r),
                      indicator: BoxDecoration(
                        color: Color(0xff007AFF),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      unselectedLabelColor: const Color(0xff8A8F9B),
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
                          child: const Tab(
                            text: 'Перекличка',
                          ),
                        ), // First tab
                        Container(
                          width: 155.w,
                          height: 41.h,
                          child: const Tab(
                            text: 'История посещений',
                          ),
                        ), // Second tab
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                const Expanded(
                  child: TabBarView(
                    children: [
                      // First tab content
                      HomeAttendance(),
                      // Second tab content
                      HomeHistory(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
