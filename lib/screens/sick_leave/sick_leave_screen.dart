import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:musait/widgets/sick_leave_input_widget.dart';
import 'package:table_calendar/table_calendar.dart';

class SickLeaveScreen extends StatefulWidget {
  const SickLeaveScreen({super.key});

  @override
  State<SickLeaveScreen> createState() => _SickLeaveScreenState();
}

class _SickLeaveScreenState extends State<SickLeaveScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;
  bool _showDatePicker = false;

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );
    if (picked != null) {
      setState(() {
        if (_fromDate == null || picked.isBefore(_fromDate!)) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Больничный",
          style: GoogleFonts.roboto(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: const Color(0xff002055),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  "Опишите по какой причине открываете больничный",
                  style: GoogleFonts.roboto(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Color(0xff002055),
                  ),
                ),
                Container(
                  height: 200.h,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: "Кратко о причине...",
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
                      SizedBox(
                        height: 10.h,
                      ),
                      TextField(
                        onTap: () {
                          setState(() {
                            _showDatePicker = !_showDatePicker;
                          });
                        },
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: "Даты",
                          suffixIcon: Image.asset("assets/images/Icon.png"),
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
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _fromDate != null
                                      ? _fromDate.toString()
                                      : "Начало",
                                  suffixIcon: Image.asset(
                                      "assets/images/icon_time.png"),
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
                            ),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: _fromDate != null
                                      ? _toDate.toString()
                                      : "Начало",
                                  suffixIcon: Image.asset(
                                      "assets/images/icon_time.png"),
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
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Visibility(
                  visible: _showDatePicker,
                  child: TableCalendar(
                    locale: 'ru_RU',
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false, // Hide the format button
                      titleCentered: true, // Center the title
                      titleTextStyle: const TextStyle(fontSize: 18),
                      titleTextFormatter: (date, locale) {
                        return DateFormat.yMMMM(locale)
                            .format(date)
                            .replaceRange(
                                0,
                                1,
                                DateFormat.yMMMM(locale)
                                    .format(date)[0]
                                    .toUpperCase());
                      }, // Customize the title text style
                    ),
                    calendarStyle: const CalendarStyle(
                      isTodayHighlighted: true,
                      todayDecoration: BoxDecoration(
                        color: Color(0xff007AFF),
                      ),
                    ),
                    focusedDay: DateTime.utc(2024, 4, 15),
                    firstDay: DateTime.utc(2024, 4, 15),
                    lastDay: DateTime.utc(2024, 12, 31),
                    rangeStartDay: _fromDate,
                    rangeEndDay: _toDate,
                    onDaySelected: (selectedDay, focusedDay) {
                      setState(() {
                        if (_fromDate == null || _toDate != null) {
                          // If there's no start date or both dates are selected, set the start date
                          _fromDate = selectedDay;
                          _toDate = null;
                        } else if (_fromDate != null &&
                            selectedDay.isAfter(_fromDate!)) {
                          // If there's a start date and the selected day is after it, set the end date
                          _toDate = selectedDay;
                        } else {
                          // Otherwise, reset the selection
                          _fromDate = selectedDay;
                          _toDate = null;
                        }
                      });
                    },
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 56.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: const Color(0xff007AFF),
                  ),
                  child: Center(
                    child: Text(
                      "Отправить",
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
