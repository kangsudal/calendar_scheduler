import 'package:drift/drift.dart';

class Schedule extends Table{
  //PRIMARY KEY
  IntColumn get id => integer()();

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
  DateTimeColumn get createdAt => dateTime()();

}