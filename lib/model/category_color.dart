import 'package:drift/drift.dart';

class CategoryColors extends Table {
  IntColumn get id => integer().autoIncrement()();         //PRIMARY KEY , => 이건 return 이고, ()() 이건 꼭 두번 해줘야 한다.
  //색상코드
  TextColumn get hexCode => text()();
}