import 'package:flutter/material.dart';
import 'package:pim_book/features/reminders/application/reminders_ctrl.dart';
import 'package:pim_book/features/reminders/ui/new_reminder_screen.dart';
import 'package:get/get.dart';
import '../../../core/theme/pim_icons.dart';
import 'component/reminder_card.dart';
import 'component/timeline_selector.dart';

class Reminders extends StatelessWidget {
  final ctrl = Get.find<RemindersController>();

  Reminders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'new_reminder',
        onPressed: () => Get.to(
          () => NewReminderScreen(),
          transition: Transition.downToUp,
          duration: Duration(milliseconds: 500),
          curve: Curves.easeOut,
        ),
        label: Text('Reminder'),
        icon: PIMIcons.fromAsset(
            iconName: PIMIcons.add_square, color: Get.theme.iconTheme.color!),
      ),
      body: GetX<RemindersController>(
        builder: (DisposableInterface controller) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(13.0),
                child: TimeLineSelector(
                  onDateChange: (date) {
                    ctrl.selectedDate = date;
                  },
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: ListView.builder(
                    itemCount: ctrl.remindersOfSelectedDate.length,
                    itemBuilder: (context, index) {
                      final reminder = ctrl.remindersOfSelectedDate[index];
                      return ReminderCard(
                        reminder: reminder,
                        onExpansionChanged: (_) {},
                        ctrl: ctrl,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
