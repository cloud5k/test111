import 'package:drift/drift.dart';

class Schedules extends Table {
  IntColumn get id => integer().autoIncrement()();  //PRIMARY KEY , => 이건 return 이고, 끝에 ()() 이건 꼭 두번 해줘야 한다.
  //내용
  TextColumn get content => text()();
  //일정날짜
  DateTimeColumn get date => dateTime()();
  //시작시간
  IntColumn get startTime => integer()();
  //끝시간
  IntColumn get endTime => integer()();
  //카테고리 칼라 테이블 아이디
  IntColumn get colorId => integer()();
  //Row 생성날짜
  DateTimeColumn get createdAt => dateTime().clientDefault(
          () => DateTime.now(),
  )();
}