import 'package:calendar_scheduler/const/colors.dart';
import 'package:flutter/material.dart';

class TodayBanner extends StatelessWidget {
  final DateTime selectedDay;
  final int scheduleCount;

  const TodayBanner({
    required this.selectedDay,
    required this.scheduleCount,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final texStyle = TextStyle(
      fontWeight: FontWeight.w600,
      color: Colors.white,
    );
    return Container(
      color: PRIMARY_COLOR,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${selectedDay.year}넌 ${selectedDay.month}월 ${selectedDay.day}일',
              style: texStyle,
            ),
            Text('$scheduleCount개',
              style: texStyle,
            ),
          ],
        ),
      ),
    );
  }
}
