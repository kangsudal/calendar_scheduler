import 'package:drift/drift.dart';

class CategoryColors extends Table{
  //PRIMARY KEY
  IntColumn get idColor => integer().autoIncrement()();

  //색상코드
  TextColumn get hexCode => text()();
}