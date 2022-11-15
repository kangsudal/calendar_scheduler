import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime? selectedDay;
  final BoxDecoration defaultDeco = BoxDecoration(
    color: Colors.grey[200],
    borderRadius: BorderRadius.circular(6),
  );
  final TextStyle defaultTextStyle = TextStyle(
    color: Colors.grey[600],
    fontWeight: FontWeight.w700,
  );
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
      //#선택한 날짜에 마크표시 코드
      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        print(selectedDay);
        setState(() {
          this.selectedDay = selectedDay;
        });
      },
      selectedDayPredicate: (day) {
        //이것까지 해줘야 마크가 된다.
        return isSameDay(selectedDay, day); //모든 날짜를 선택한 날짜와 비교한다. true인 날짜만 마크.
      },
      //#선택한 날짜에 마크표시 코드 end
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,
        defaultDecoration: defaultDeco,
        weekendDecoration: defaultDeco,
        selectedDecoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: primaryColor),
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
            color: primaryColor), //나머지는 다 똑같고 color만 바꾼다
      ),
    );
  }
}
