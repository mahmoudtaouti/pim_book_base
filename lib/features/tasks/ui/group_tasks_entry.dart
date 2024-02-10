import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../application/group_tasks_ctrl.dart';
import 'component/add_task_units_box.dart';

class NewGroupTaskScreen extends StatelessWidget {
  static const routeName = '/new_group_task';
  final ctrl = NewGroupTaskController();
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('New Group Task'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(vertical: 9,horizontal: 23),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                ctrl.pickDueDate(() async {
                  return await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(Duration(days: 365)),
                  );
                });
                //newGroupTaskController.createGroupTask();
              },
              icon: Icon(
                Icons.calendar_month_rounded,
                color: Get.theme.colorScheme.onSurfaceVariant,
                size: 28,
              ),
            ),
            Text('Edited\n${DateFormat.yMMMd().format(DateTime.now())}',style: Get.textTheme.bodySmall,textAlign: TextAlign.center,),
            IconButton(
              onPressed: () {
                ctrl.createGroupTask();
              },
              icon: Icon(
                Icons.check_circle,
                color: Get.theme.colorScheme.onSurfaceVariant,
                size: 52,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(bottom: 90,left: 12,right: 12,top: 8),
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(8),
              child: TextField(
                controller: ctrl.titleController,
                style: Get.theme.textTheme.headlineMedium,
                decoration: InputDecoration(
                  icon: Icon(CupertinoIcons.pencil_circle),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  hintText: 'Title.',
                ),
              ),
            ),
            SizedBox(height: 16),
            TaskUnitsInput(controller: ctrl),
            SizedBox(height: 70),
          ],
        ),
      ),
    );
  }
}


