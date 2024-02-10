
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils.dart';
import '../../application/tasks_ctrl.dart';
import '../../domain/task.dart';
import 'custom_check_box.dart';

// GroupTaskTile
class GroupTaskTile extends StatefulWidget {
  final GroupTask groupTask;
  final TasksController ctrl;

  GroupTaskTile({required this.groupTask, required this.ctrl});

  @override
  _GroupTaskTileState createState() => _GroupTaskTileState();
}

class _GroupTaskTileState extends State<GroupTaskTile> {
  bool allTasksChecked = false;

  @override
  void initState() {
    super.initState();
    allTasksChecked =
        widget.groupTask.taskUnits.every((taskUnit) => taskUnit.checked);
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: allTasksChecked ? Colors.green : Colors.orangeAccent.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      child: InkWell(
        onLongPress: () {
          _showDeleteTaskBottomSheet(context);
        },
        child: Column(
          children: [
            ListTile(
              title: Text(widget.groupTask.title,
                  style: Theme.of(context).textTheme.titleMedium),
              subtitle: Text('${widget.groupTask.taskUnits.length} tasks',
                  style: Theme.of(context).textTheme.labelLarge),
              trailing: Text(widget.ctrl.displayDateIfValid(widget.groupTask)),
            ),
            Column(
              children: [
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.groupTask.taskUnits.length,
                  itemBuilder: (context, index) {
                    if (index < 3) {
                      return ListTile(
                        title: Text(widget.groupTask.taskUnits[index].title,
                            style: Theme.of(context).textTheme.titleSmall),
                        leading: CustomCheckbox(
                          value: widget.groupTask.taskUnits[index].checked,
                          onChanged: (value) {
                            widget.groupTask.taskUnits[index].checked =
                                value ?? false;
                            widget.ctrl
                                .updateGroupTaskCheckedStatus(widget.groupTask);
                            setState(() {
                              allTasksChecked = widget.groupTask.taskUnits
                                  .every((taskUnit) => taskUnit.checked);
                            });
                          },
                        ),
                        dense: true,
                      );
                    } else if (index == 3){
                      return Container(
                        alignment: Alignment.center,
                        child: TextButton(
                          child: Text('Tap to see more tasks'),
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => BottomSheetContent(
                                taskUnits: widget.groupTask.taskUnits,
                                onTaskUnitChecked: (index, value) {
                                  widget.groupTask.taskUnits[index].checked = value;
                                  widget.ctrl.updateGroupTaskCheckedStatus(widget.groupTask);
                                  setState(() {
                                    allTasksChecked = widget.groupTask.taskUnits
                                        .every((taskUnit) => taskUnit.checked);
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }


  void _showDeleteTaskBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Delete Task',
                style: Get.textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              Text(
                'Are you sure you want to delete this Group?',
                style: Get.textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the BottomSheet
                  // Perform the delete operation here
                  widget.ctrl.deleteThisGroup(widget.groupTask);
                },
                child: Text('Delete'),
              ),
            ],
          ),
        );
      },
    );
  }
}



// BottomSheetContent
class BottomSheetContent extends StatefulWidget {
  final List<TaskUnit> taskUnits;
  final Function(int, bool) onTaskUnitChecked;

  BottomSheetContent(
      {required this.taskUnits, required this.onTaskUnitChecked});

  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          color: Theme.of(context).colorScheme.surface),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: ListView.builder(
        itemCount: widget.taskUnits.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.taskUnits[index].title,
                style: Theme.of(context).textTheme.titleSmall),
            leading: CustomCheckbox(
              value: widget.taskUnits[index].checked,
              onChanged: (value) {
                widget.onTaskUnitChecked(index, value ?? false);
                setState(() {});
              },
            ),
            dense: true,
          );
        },
      ),
    );
  }
}
