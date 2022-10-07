import 'package:calendar_scheduler/database/drift_database.dart';
import 'package:calendar_scheduler/screen/home_screen.dart';
import 'package:drift/drift.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/date_symbol_data_local.dart';

const DEFAULT_COLORS = [
  'f44336',
  'ff9800',
  'ffeb3b',
  'fcaf50',
  '2196f3',
  '3f51b5',
  '9c27b0',   //빨주노초파남보
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();   //아래꺼를 runApp이 실행되기 전에 실행할수 있게 해주는 함수.
  await initializeDateFormatting();   //import 'package:intl/date_symbol_data_local.dart'; 이거를 호출해준다.

  print('----------데이터 베이스 사용하기--------------');
  final database = LocalDatabase();

  GetIt.I.registerSingleton<LocalDatabase>(database);   //디비값 받기 07   database값을 이제 어디서든 사용가능하다. (디펜던시 인젝션)

  final colors = await database.getCategoryColors();     //01 drift_database.dart select를 이용해 색깔 데이터를 가져온다.

  if(colors.isEmpty){                                 //02 데이터베이스 색깔데이터가 없다.
    for(String hexCode in DEFAULT_COLORS){
      await database.createCategoryColor(             //03 drift_database.dart에 있는 insert를 사용한다.
        CategoryColorsCompanion(
          hexCode: Value(hexCode),                  //04 값은 항상 Value()로 감싸야 한다.
        )
      );
    }
  }
  print(await database.getCategoryColors());

  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'NotoSans',
    ),
    home: HomeScreen(),
  ));
}
