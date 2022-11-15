import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); //플러터 프레임워크가 준비가 된상태인지 체크하고 기다림
  await initializeDateFormatting(); //intl 안에 있는 모든 언어를 다 사용할 수 있게됨(날짜관련)
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'NotoSans'),
      home: HomeScreen(),
    ),
  );
}
