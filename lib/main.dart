import 'package:calendar_scheduler/database/drift_database.dart'; //LocalDatabase
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart'; //Value()
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  //연보라색
  'A175F6',
  //진보라
  '46169E',
  //하늘색
  '5DA0D9',
  //파란색
  '234DA1',
  //민트색
  '8CC9A6',
  //초록색
  '145742',
  //노란색
  'E3D267',
  //올리브색
  //핑크색
  //자주색
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //플러터 프레임워크가 준비가 된상태인지 체크하고 기다림
  await initializeDateFormatting(); //intl 안에 있는 모든 언어를 다 사용할 수 있게됨(날짜관련)
  final database = LocalDatabase(); // 내가 만든 클래스
  final colors =
      await database.getCategoryColors(); //Future이기때문에 await. 선언한 select 쿼리 사용.
  if (colors.isEmpty) {//데이터베이스의(하드드라이브에 저장된) List<CategoryColor> 데이터가 RAM으로 불러올게 없으면
    for (String hexCode in DEFAULT_COLORS) {
      await database.createCategoryColor(
        CategoryColorsCompanion(
          hexCode: Value(hexCode),
        ),
      );
    }
  } //데이터베이스에 데이터가 안들어있으면 CategoryColorsCompanion이라는 entity들을 넣어준다.

  print(await database.getCategoryColors());

  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: HomeScreen(),
    ),
  );
}
