//private 값은 불러올 수 없다.
import 'dart:async';
import 'dart:io';

import 'package:calendar_scheduler/model/category_color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart'; //getApplicationDocumentsDirectory
import 'package:path/path.dart' as p;

//private 값도 불러올 수 있다.
part 'drift_database.g.dart'; //커맨드 'flutter pub run build_runner build' 자동으로 생성된 파일

@DriftDatabase(
  tables: [
    //데이터베이스 테이블로 인식되게 한다
    Schedules,
    CategoryColors,
  ],
)
class LocalDatabase extends _$LocalDatabase {
  //drift가 만들어주는 클래스. drift_database.g.dart 안에 생성된다.
  // we tell the database where to store the data with this constructor
  LocalDatabase() : super(_openConnection());

  //query
  //INSERT
  //Future<int>인 이유는 생성한 row의 primary key를 반환받기때문
  Future<int> createSchedule(SchedulesCompanion data) =>
      into(schedules).insert(data);
  //into(테이블명).insert(어쩌구Companion 객체)
  //어떤 테이블에다가 data를 넣을거다

  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);

  //SELECT
  Future<List<CategoryColor>> getCategoryColors() => select(categoryColors).get();
  //한번에 CategoryColor들을 테이블에서 모두 가져오는 기능. categoryColors는 테이블명

  @override
  // 테이블 구조가 바뀔때마다 버전을 업그레이드해야한다.
  int get schemaVersion => 1;
}

//보조기억장치인 하드드라이브에 어떤 위치에 저장할지 명시
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder =
        await getApplicationDocumentsDirectory(); //앱별로 배정받은 하드드라이브 위치
    //dbFolder에 db.sqlite File을 만들어준다. final file = File(위치);
    final file =
        File(p.join(dbFolder.path, 'db.sqlite')); //db.sqlite에 데이터를 저장한다.
    return NativeDatabase(file); //file로 데이터베이스를 만든다
  });
}
