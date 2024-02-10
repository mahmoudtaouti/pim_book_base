import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../application/group_tasks_ctrl.dart';

class TaskUnitsInput extends StatelessWidget {
  final NewGroupTaskController controller;

  TaskUnitsInput({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Get.theme.colorScheme.onSurfaceVariant,
              width: 2.0,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: controller.taskUnits.map((taskUnit) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        title: Text(
                          taskUnit,
                          style: Get.textTheme.titleLarge,
                        ),
                        //tileColor: Colors.black12,
                        trailing: IconButton(
                          icon: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                border: Border.all(
                                  color: Get.theme.colorScheme.onSurfaceVariant,
                                  width: 1.0,
                                ),
                              ),
                              child: Icon(Icons.delete, size: 12,)),
                          onPressed: () {
                            controller.removeTaskUnit(taskUnit);
                          },
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: controller.newTaskUnitController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.add_box_outlined),
                    hintText: 'Add task',
                    border: OutlineInputBorder(borderSide: BorderSide.none),
                    enabledBorder:
                    OutlineInputBorder(borderSide: BorderSide.none),
                    focusedBorder:
                    OutlineInputBorder(borderSide: BorderSide.none),
                  ),
                  onSubmitted: (value) {
                    controller.addTaskUnit(value);
                  },
                  onTap: () {
                    controller.addTaskUnit(controller.newTaskUnitController.text);
                  },
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}