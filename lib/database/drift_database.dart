//import는 private 값은 불러올 수 없다.
import 'dart:io';

import 'package:calendar_scheduler/model/category_color.dart';
import 'package:calendar_scheduler/model/schedule.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

//private 값도 불러올수 잇다.
part 'drift_database.g.dart';       //데이터베이스를 사용하기 위해 불러오는 곳은 main.dart

@DriftDatabase(
  tables: [
    Schedules,
    CategoryColors,        //테이블을 불러온다.
  ],
)
class LocalDatabase extends _$LocalDatabase{
  LocalDatabase() : super(_openConnection());

  Future<int> createSchedule(SchedulesCompanion data) =>  //insert(data)가 프라이머리키 Future<int>값을 반환한다.
      into(schedules).insert(data);
  Future<int> createCategoryColor(CategoryColorsCompanion data) =>
      into(categoryColors).insert(data);
  Future<List<CategoryColor>> getCategoryColors() =>
      select(categoryColors).get();                        //List로 모두 가져오려면 get()을 사용해야한다.

  @override
  int get schemaVersion => 1;
}
LazyDatabase _openConnection(){
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));   //무조건 dart:io를 불러온다 dart:html은 웹에서 쓴다.
    return NativeDatabase(file);   //이렇게 해주면 로컬데이터 베이스 생성끝
  });
}