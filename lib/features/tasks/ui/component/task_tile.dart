import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../core/utils.dart';
import '../../application/tasks_ctrl.dart';
import '../../domain/task.dart';
import 'package:get/get.dart';

import 'custom_check_box.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  final TasksController ctrl;
  final Function(bool) onChange;

  TaskTile({Key? key, required this.task, required this.onChange, required this.ctrl})
      : super(key: key);

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    bool isDueDate = !widget.task.checked &&
        Utils.areDatesEqual(DateTime.now(),
            DateTime.fromMillisecondsSinceEpoch(widget.task.dueDate));

    return InkWell(
      onLongPress: () {
        _showDeleteTaskBottomSheet(context);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            ListTile(
              contentPadding: EdgeInsets.only(left: 0, right: 15),
              title: Text(
                widget.task.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  isDueDate
                      ? Flexible(
                    child: Icon(
                      Icons.warning_amber_rounded,
                      size: 18,
                      color: Get.theme.colorScheme.error,
                    ),
                  )
                      : SizedBox.shrink(),
                  SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      widget.ctrl.displayDateIfValid(widget.task),
                      style: Get.theme.textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
              leading: GestureDetector(
                onTap: () {},
                child: CustomCheckbox(
                  value: widget.task.checked,
                  onChanged: (value) {
                    widget.onChange(value ?? false);
                    setState(() {});
                  },
                ),
              ),
            ),
            Container(
              height: 1.5,
              margin: EdgeInsets.symmetric(horizontal: 5),
              width: double.infinity,
              decoration: BoxDecoration(
                color: widget.task.checked
                    ? Colors.transparent
                    : Colors.orangeAccent.withOpacity(0.5),
              ),
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
          width: Get.width,
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
                widget.task.title,
                style: Get.textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the BottomSheet
                  // Perform the delete operation here
                  widget.ctrl.deleteThisTask(widget.task);
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

// getCheckBox() {
//   return Container(
//     width: 24,
//     height: 24,
//     decoration: BoxDecoration(
//       border: Border.all(
//           color: widget.task.checked ? Colors.green : Colors.grey, width: 2),
//       borderRadius: BorderRadius.circular(4),
//       color: widget.task.checked ? Colors.green : Colors.transparent,
//       boxShadow: widget.task.checked
//           ? [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.3),
//                 spreadRadius: 0.9,
//                 blurRadius: 4,
//                 offset: Offset(1, 0),
//               )
//             ]
//           : [],
//     ),
//   );
// }
