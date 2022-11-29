import 'package:calendar_scheduler/database/drift_database.dart';

/*
categoryColors 테이블과 selectedData로 필터된 schedule 테이블을 innerJoin한 테이블을 담는 클래스
 */
class ScheduleWithColor {
  final Schedule schedule;
  final CategoryColor categoryColor;

  ScheduleWithColor({
    required this.schedule,
    required this.categoryColor,
  });
}
