import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;
  final DateTime focusedDay;
  final OnDaySelected? onDaySelected;

  const Calendar({
    Key? key,
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BoxDecoration defaultDeco = BoxDecoration(
      color: Colors.grey[200],
      borderRadius: BorderRadius.circular(6),
    );
    final TextStyle defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w700,
    );
    return TableCalendar(
      locale: 'ko_KR', //한글로 변경
      focusedDay: focusedDay,
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
      onDaySelected: onDaySelected,
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
        outsideDecoration: BoxDecoration(shape: BoxShape.rectangle),
      ),
    );
  }
}
