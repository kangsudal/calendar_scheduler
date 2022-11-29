import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/model/schedule_with_color.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              onDaySelected: onDaySelected,
              selectedDay: selectedDay,
              focusedDay: focusedDay,
            ),
            SizedBox(
              height: 8,
            ),
            TodayBanner(selectedDay: selectedDay, scheduleCount: 3),
            SizedBox(
              height: 8,
            ),
            _ScheduleList(
              selectedDate: selectedDay,
            ),
          ],
        ),
      ),
    );
  }

  FloatingActionButton renderFloatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        //BottomSheet가 뜨도록 만드는 코드
        showModalBottomSheet(
          context: context,
          isScrollControlled: true, //BottomSheet 최대 높이 제한 해제(키보드 위로 올라오도록(3))
          builder: (context) {
            return ScheduleBottomSheet(
              selectedDay: selectedDay,
            );
          },
        );
      },
      child: Icon(Icons.add),
      backgroundColor: primaryColor,
    );
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    // print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;
      this.focusedDay = selectedDay; //보고있는 화면이 선택한 달로 이동
    });
  }
}

class _ScheduleList extends StatelessWidget {
  final DateTime selectedDate;
  const _ScheduleList({required this.selectedDate, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: StreamBuilder<List<ScheduleWithColor>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasData && snapshot.data!.isEmpty) {
                return Center(
                  child: Text('스케쥴이 없습니다.'),
                );
              }
              return ListView.separated(
                itemCount:
                    snapshot.data!.length, //db에서 가져온 데이터(필터된 schedule들)의 길이만큼
                itemBuilder: (context, index) {
                  final scheduleWithColor = snapshot.data![index];
                  return ScheduleCard(
                    startTime: scheduleWithColor.schedule.startTime,
                    endTime: scheduleWithColor.schedule.endTime,
                    content: scheduleWithColor.schedule.content,
                    color: Color(int.parse(
                        'FF${scheduleWithColor.categoryColor.hexCode}',radix: 16)),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 8,
                  );
                },
              );
            }),
      ),
    );
  }
}
