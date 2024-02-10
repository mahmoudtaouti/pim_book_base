import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../application/tasks_ctrl.dart';
import '../domain/task.dart';
import 'component/group_task_tile.dart';
import 'component/task_tile.dart';

class TasksListView extends GetView<TasksController> {
  final TasksController ctrl;

  final int filter;
  TasksListView({required this.ctrl, required this.filter});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: ctrl.tasks.length + 1,
            itemBuilder: (context, index) {
              if (index < ctrl.tasks.length) {
                final task = ctrl.tasks[index];
                if (task is Task && (filter == 0 || filter == 1)) {
                  return _buildTaskTile(context, task);
                }
                if (task is GroupTask && (filter == 0 || filter == 2)) {
                  return _buildGroupTask(context, task);
                } else {
                  return SizedBox.shrink();
                }
              } else {
                if (index < 20) {
                  String message = index == 0
                      ? 'Your to-do list seems a bit light. Let\'s make it more exciting – add some tasks!'
                      : '';
                  message = 0 < index && index <= 6
                      ? 'No worries, Rome wasn\'t built in a day! Add a few more tasks to see the magic.'
                      : message;
                  message = 6 < index && index <= 16
                      ? 'Your list is growing! Each task completed is a step closer to your goals.'
                      : message;
                  message = 16 < index
                      ? 'Your task list is booming! Give yourself a well-deserved pat on the back.'
                      : message;

                  return Container(
                    height: Get.size.height / 1.2,
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 32),
                    child: Center(
                      child: Text(
                        message,
                        style: Get.textTheme.displayMedium
                            ?.copyWith(fontWeight: FontWeight.w200),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
              }
            }),
      ),
    );
  }

  Widget _buildTaskTile(BuildContext context, Task task) {
    return TaskTile(
      task: task,
      onChange: (value) {
        ctrl.updateTaskCheckedStatus(task, value);
        ctrl.update();
      },
      ctrl: ctrl,
    );
  }

  _buildGroupTask(BuildContext context, GroupTask groupTask) {
    return GroupTaskTile(
      groupTask: groupTask,
      ctrl: ctrl,
    );
  }

  Widget _buildUnknownTaskTile() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: CupertinoActivityIndicator(),
    );
  }
}
