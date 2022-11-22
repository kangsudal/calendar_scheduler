//private 값은 불러올 수 없다.
import 'dart:io';

import 'package:calendar_scheduler/model/category_color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';//getApplicationDocumentsDirectory
import 'package:path/path.dart' as p;

//private 값도 불러올 수 있다.
part 'drift_database.g.dart'; //커맨드 자동으로 생성된 파일

@DriftDatabase(
  tables: [ //데이터베이스 테이블로 인식되게 한다
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase{ //drift가 만들어주는 클래스. drift_database.g.dart 안에 생성된다.
  // we tell the database where to store the data with this constructor
  LocalDatabase() : super(_openConnection());
}

//보조기억장치인 하드드라이브에 어떤 위치에 저장할지 명시
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();//앱별로 배정받은 하드드라이브 위치
    //dbFolder에 db.sqlite File을 만들어준다. final file = File(위치);
    final file = File(p.join(dbFolder.path, 'db.sqlite'));//db.sqlite에 데이터를 저장한다.
    return NativeDatabase(file);//file로 데이터베이스를 만든다
  });
}