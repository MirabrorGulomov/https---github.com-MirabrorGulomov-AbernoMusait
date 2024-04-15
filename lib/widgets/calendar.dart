import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarWidget extends StatelessWidget {
  const CalendarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ru_RU',
      headerStyle: HeaderStyle(
        formatButtonVisible: false, // Hide the format button
        titleCentered: true, // Center the title
        titleTextStyle: const TextStyle(fontSize: 18),
        titleTextFormatter: (date, locale) {
          return DateFormat.yMMMM(locale).format(date).replaceRange(
              0, 1, DateFormat.yMMMM(locale).format(date)[0].toUpperCase());
        }, // Customize the title text style
      ),
      calendarStyle: const CalendarStyle(
        isTodayHighlighted: true,
        todayDecoration: BoxDecoration(
          color: Color(0xff007AFF),
          shape: BoxShape.circle,
        ),
      ),
      focusedDay: DateTime.utc(2024, 4, 15),
      firstDay: DateTime.utc(2024, 4, 15),
      lastDay: DateTime.utc(2024, 12, 31),
      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, _) {
          // Return your custom styled day widget here
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _getDayColor(date),
            ),
            child: Text(
              '${date.day}',
              style: TextStyle(
                color: _getDayTextColor(date),
              ),
            ),
          );
        },
      ),
    );
  }

  Color _getDayColor(DateTime date) {
    // Logic to determine the background color of the day
    if (date.weekday == DateTime.monday) {
      return const Color(0xffE92020);
    } else if (date.weekday == DateTime.tuesday) {
      return const Color(0xff0BAC00);
    } else if (date.weekday == DateTime.wednesday) {
      return const Color(0xffFFB1B1);
    } else {
      return Colors.transparent;
    }
  }

  Color _getDayTextColor(DateTime date) {
    // Logic to determine the text color of the day
    if (date.weekday == DateTime.monday) {
      return Colors.white;
    } else if (date.weekday == DateTime.tuesday) {
      return Colors.white;
    } else if (date.weekday == DateTime.wednesday) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }
}
