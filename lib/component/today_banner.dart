import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  const TodayBanner({
    required this.selectedDay,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.w600);
    return Container(
      color: primaryColor,
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${selectedDay.year}년 ${selectedDay.month}월 ${selectedDay.day}일',
            style: textStyle,
          ),
          StreamBuilder<List<ScheduleWithColor>>(
              stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDay),
              builder: (context, snapshot) {
                int count = 0;
                if (snapshot.hasData) {
                  count = snapshot.data!.length;
                }
                return Text(
                  '$count개',
                  style: textStyle,
                );
              }),
        ],
      ),
    );
  }
}
