import 'package:calendar_scheduler/component/calendar.dart';
import 'package:calendar_scheduler/component/schedule_bottom_sheet.dart';
import 'package:calendar_scheduler/component/schedule_card.dart';
import 'package:calendar_scheduler/component/today_banner.dart';
import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDay = DateTime(        //외부로 값빼기 06 함수안의 변수들 선언해주고,
    DateTime.now().year,                   // selectedDay null일 수 없게 미리 오늘 날짜를 넣어준다.
    DateTime.now().month,
    DateTime.now().day,
  );
  DateTime focusedDay = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: renderFloatingActionButton(),
      body: SafeArea(
        child: Column(
          children: [
            Calendar(
              selectedDay: selectedDay,         //외부로 값빼기 07끝 외부 변수 넣어주고
              focusedDay: focusedDay,
              onDaySelected: onDaySelected,      //외부로 값빼기 05 외부 함수 선언 넣어주고
            ),
            SizedBox(height: 8.0,),
            TodayBanner(
              selectedDay: selectedDay,     //selectedDay가 null일 수 없게 해준다.
              scheduleCount: 3,
            ),
            SizedBox(height: 8.0,),
            _ScheduleList(),
          ],
        ),
      ),
    );
  }
  FloatingActionButton renderFloatingActionButton(){
    return FloatingActionButton(
      onPressed: (){
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,          //모달창이 절반 이상 더이상 안올라갈때
          builder: (_){
            return ScheduleBottomSheet();
          },
        );
      },
      backgroundColor: PRIMARY_COLOR,
      child: Icon(
        Icons.add,
      ),
    );
  }

  onDaySelected(DateTime selectedDay, DateTime focusedDay){ //외부로 값빼기 04 함수선언해주고
    print(selectedDay);
    setState(() {
      this.selectedDay = selectedDay;  //클릭한 날짜 저장
      this.focusedDay = selectedDay;    //이번달 말고 다른달도 클릭하면 포커스를 이동하여 준다.
    });
  }
}

class _ScheduleList extends StatelessWidget {
  const _ScheduleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: ListView.separated(
            itemCount: 100,
            separatorBuilder: (context, index){
              return SizedBox(height: 8.0,);  //리스트 사이에 간격 8px넣는다.
            },
            itemBuilder: (context, index){
              return ScheduleCard(
                startTime: 8,
                endTime: 14,
                content: '포그로그래밍 공부하기 $index',
                color: Colors.red,
              );
            }
        ),
      ),
    );
  }
}

