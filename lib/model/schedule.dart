import 'package:drift/drift.dart';

class Schedules extends Table{
  //PRIMARY KEY
  IntColumn get id => integer().autoIncrement()();//autoIncrement()는 자동으로 숫자를 늘림

  //내용
  TextColumn get content => text()();

  //일정 날짜
  DateTimeColumn get date => dateTime()();

  //시작시간
  IntColumn get startTime => integer()();

  //끝시간
  IntColumn get endTime => integer()();

  //Category Color Table ID
  IntColumn get colorId => integer()();

  //생성날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(
        () => DateTime.now(),
  )();//clientDefault: 값을 안넣었을때만 DateTime.now()가 실행됨

}