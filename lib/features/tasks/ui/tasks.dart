import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/tasks/ui/group_tasks_entry.dart';
import 'package:pim_book/features/tasks/ui/new_task.dart';
import 'package:pim_book/features/tasks/ui/tasks_list.dart';
import '../../../core/theme/pim_icons.dart';
import '../application/tasks_ctrl.dart';

class Tasks extends StatelessWidget {
  Tasks({Key? key}) : super(key: key);
  final tasksCtrl = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.extended(
              heroTag: 'new_task',
              onPressed: () => Get.bottomSheet(NewTaskScreen()),
              label: Text('Task'),
              icon: PIMIcons.fromAsset(
                  iconName: PIMIcons.add_square,
                  color: Get.theme.colorScheme.onSurfaceVariant),
            ),
            SizedBox(
              width: 15,
              height: 15,
            ),
            FloatingActionButton.extended(
              heroTag: 'new_group',
              onPressed: () => Get.to(
                () => NewGroupTaskScreen(),
                transition:
                    Transition.downToUp, // Specify the transition animation
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOut,
              ),
              label: Text('Create Group'),
              icon: PIMIcons.fromAsset(
                  iconName: PIMIcons.group_task,
                  color: Get.theme.colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        body: Obx(() {
          return Container(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: CupertinoSlidingSegmentedControl<int>(
                    onValueChanged: (value) {
                      tasksCtrl.changeSegment(value ?? 0);
                    },
                    groupValue: tasksCtrl.currentSegment,
                    children: {
                      0: Container(
                          padding: EdgeInsets.all(12), child: Text('All')),
                      1: Container(
                          padding: EdgeInsets.all(12), child: Text('Tasks')),
                      2: Container(
                          padding: EdgeInsets.all(12), child: Text('Groups')),
                    },
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Expanded(
                  child: IndexedStack(
                    index: tasksCtrl.currentSegment,
                    children: [
                      TasksListView(
                        ctrl: tasksCtrl,
                        filter: tasksCtrl.currentSegment,
                      ),
                      TasksListView(
                        ctrl: tasksCtrl,
                        filter: tasksCtrl.currentSegment,
                      ),
                      TasksListView(
                        ctrl: tasksCtrl,
                        filter: tasksCtrl.currentSegment,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }));
  }
}
