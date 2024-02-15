import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';


class TimeLineSelector extends StatelessWidget {

  final Function(DateTime) onDateChange;
  TimeLineSelector({
    Key? key,
    required this.onDateChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasyDateTimeLine(
      onDateChange: (DateTime date) {
        this.onDateChange.call(date);
      },
      initialDate: DateTime.now(),
      activeColor: Get.theme.colorScheme.tertiary,
      headerProps: const EasyHeaderProps(
        dateFormatter: DateFormatter.monthOnly(),
      ),
      dayProps: const EasyDayProps(
        height: 83.0,
        width: 56.0,
        dayStructure: DayStructure.dayNumDayStr,
        inactiveDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            fontSize: 18.0,
          ),
        ),
        activeDayStyle: DayStyle(
          dayNumStyle: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
