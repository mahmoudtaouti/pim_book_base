import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/tasks/ui/group_tasks_entry.dart';
import 'package:pim_book/features/tasks/ui/new_task.dart';
import 'package:pim_book/features/tasks/ui/tasks_list.dart';
import '../../../core/theme/pim_icons.dart';
import '../application/tasks_ctrl.dart';

class Tasks extends StatelessWidget {

  final tasksCtrl = Get.put(TasksController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            onPressed: ()=> Get.bottomSheet(NewTaskScreen()),
            label: Text('New'),
            icon: PIMIcons.fromAsset(iconName: PIMIcons.document,color: Get.theme.colorScheme.onInverseSurface),
          ),
          SizedBox(width: 15,height: 15,),
          FloatingActionButton.extended(
            onPressed: ()=> Get.to(NewGroupTaskScreen()),
            label: Text('New Group'),
            icon: PIMIcons.fromAsset(iconName: PIMIcons.document_text,color: Get.theme.colorScheme.onInverseSurface),
          ),
        ],
      ),
        body: Obx(() {
            return Container(
              child: Column(
                children: [
                  CupertinoSlidingSegmentedControl<int>(
                    onValueChanged: (value){
                      tasksCtrl.changeSegment(value ?? 0);
                    },
                    groupValue:  tasksCtrl.currentSegment,
                    children: {
                      0:Container(padding: EdgeInsets.all(12), child: Text('All')),
                      1:Container(padding: EdgeInsets.all(12), child: Text('Tasks')),
                      2:Container(padding: EdgeInsets.all(12), child: Text('Groups')),
                    },
                  ),
                  SizedBox(height: 15,),
                  Expanded(child: IndexedStack(
                    index: tasksCtrl.currentSegment,
                    children: [
                      TasksListView(ctrl: tasksCtrl, filter: tasksCtrl.currentSegment,),
                      TasksListView(ctrl: tasksCtrl, filter: tasksCtrl.currentSegment,),
                      TasksListView(ctrl: tasksCtrl, filter: tasksCtrl.currentSegment,),
                    ],
                  ),),
                ],
              ),
            );
          }
        )
        );
  }
}
