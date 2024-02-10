import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/tasks/application/tasks_ctrl.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';

import '../application/new_task_ctrl.dart';

class NewTaskScreen extends StatelessWidget {
  static const routeName = '/new_task';
  final ctrl = Get.put(NewTaskController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
          color: Get.theme.colorScheme.surface,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: ListTile(
        title: TextField(
          style: Get.textTheme.headlineSmall,
          controller: ctrl.titleController,
          decoration: InputDecoration(
              hintText: 'Title', hintStyle: Get.textTheme.headlineSmall),
          autofocus: true,
          focusNode: ctrl.focusNode,
          onSubmitted: (_) async {
            ctrl.createTask(TasksDBWorker());
          },
        ),
        trailing: IconButton(
          icon: Icon(Icons.calendar_month_rounded),
          onPressed: () {
            ctrl.selectDate(() async {
              return await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(Duration(days: 365)),
              );
            });
          },
        ),
      ),
    );
  }
}
