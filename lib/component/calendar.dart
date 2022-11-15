import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime(1950),
      lastDay: DateTime(2050),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 16,
        ),
      ),
      onDaySelected: (DateTime selectedDay, DateTime focusedDay){
        setState(() {
          this.selectedDay = selectedDay;
        });

      },
      selectedDayPredicate: (day) {//이것까지 해줘야 마크가 된다.
        return isSameDay(selectedDay, day);//모든 날짜를 선택한 날짜와 비교한다. true인 날짜만 마크.
      },

    );
  }
}
