import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatelessWidget {
  final DateTime? selectedDay;     //외부로 값빼기 01 home_screen.dart 에서 사용하기 위해 변수로 만든다.
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;
  const Calendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final defaultBoxDeco = BoxDecoration(
      borderRadius: BorderRadius.circular(0.6),
      color: Colors.grey[200],
    );
    final defaultTextStyle = TextStyle(
      color: Colors.grey[600],
      fontWeight: FontWeight.w600,
    );
    return TableCalendar(
      locale: 'ko_KR',   //main.dart 에서 await initializeDateFormatting(); 이게 실행되어야 한다.
      focusedDay: focusedDay,    //외부로 값빼기 02 statefulWidget 이기 때문에 변수에 widget.을 붙여준다. stateless면 필요없다.
      firstDay: DateTime(1900),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,  //2weeks버튼 삭제
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      calendarStyle: CalendarStyle(
        isTodayHighlighted: false,          //오늘날짜 표시할지 안할지
        defaultDecoration: defaultBoxDeco,
        weekendDecoration: defaultBoxDeco,
        selectedDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: Colors.white,
          border: Border.all(
            color: PRIMARY_COLOR,
            width: 1.0,
          )
        ),
        defaultTextStyle: defaultTextStyle,
        weekendTextStyle: defaultTextStyle,
        selectedTextStyle: defaultTextStyle.copyWith(
          color: PRIMARY_COLOR,
        ),
        outsideDecoration: BoxDecoration(      //이번달 외 날짜들의 박스데코를 사각형으로 해준다.
          shape: BoxShape.rectangle,
        )
      ),
      onDaySelected: onDaySelected,          //외부로 값빼기 03 함수는 home_screen.dart로 이동.
      selectedDayPredicate: (DateTime date){
        if(selectedDay == null){
          return false;
        }
        return date.year == selectedDay!.year &&
            date.month == selectedDay!.month &&
            date.day == selectedDay!.day;
      },
    );
  }
}


/* 아래는 StatefulWidget 일때 다른점은 위에 클래스에 선언한 변수나 함수들 앞에 아래 클래스에서 widget.focusedDay 이렇게 붙여줘야한다.
class Calendar extends StatefulWidget {
  final DateTime? selectedDay;     //외부로 값빼기 01 home_screen.dart 에서 사용하기 위해 변수로 만든다.
  final DateTime focusedDay;
  final OnDaySelected onDaySelected;
  const Calendar({
    required this.selectedDay,
    required this.focusedDay,
    required this.onDaySelected,
    Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  final defaultBoxDeco = BoxDecoration(
    borderRadius: BorderRadius.circular(0.6),
    color: Colors.grey[200],
  );
  final defaultTextStyle = TextStyle(
    color: Colors.grey[600],
    fontWeight: FontWeight.w600,
  );

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      locale: 'ko_KR',   //main.dart 에서 await initializeDateFormatting(); 이게 실행되어야 한다.
      focusedDay: widget.focusedDay,    //외부로 값빼기 02 statefulWidget 이기 때문에 변수에 widget.을 붙여준다. stateless면 필요없다.
      firstDay: DateTime(1900),
      lastDay: DateTime(3000),
      headerStyle: HeaderStyle(
        formatButtonVisible: false,  //2weeks버튼 삭제
        titleCentered: true,
        titleTextStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20.0,
        ),
      ),
      calendarStyle: CalendarStyle(
          isTodayHighlighted: false,          //오늘날짜 표시할지 안할지
          defaultDecoration: defaultBoxDeco,
          weekendDecoration: defaultBoxDeco,
          selectedDecoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6.0),
              color: Colors.white,
              border: Border.all(
                color: PRIMARY_COLOR,
                width: 1.0,
              )
          ),
          defaultTextStyle: defaultTextStyle,
          weekendTextStyle: defaultTextStyle,
          selectedTextStyle: defaultTextStyle.copyWith(
            color: PRIMARY_COLOR,
          ),
          outsideDecoration: BoxDecoration(      //이번달 외 날짜들의 박스데코를 사각형으로 해준다.
            shape: BoxShape.rectangle,
          )
      ),
      onDaySelected: widget.onDaySelected,          //외부로 값빼기 03 함수는 home_screen.dart로 이동.
      selectedDayPredicate: (DateTime date){
        if(widget.selectedDay == null){
          return false;
        }
        return date.year == widget.selectedDay!.year &&
            date.month == widget.selectedDay!.month &&
            date.day == widget.selectedDay!.day;
      },
    );
  }
}
*/