import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pim_book/features/tasks/data/tasks_db_worker.dart';
import 'package:pim_book/features/tasks/domain/tasks_model.dart' show TasksModel;
import 'package:pim_book/features/tasks/ui/tasks_entry.dart';
import 'package:pim_book/features/tasks/ui/tasks_list.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';

class Tasks extends StatefulWidget {

  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {




  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: Provider.of<TasksModel>(context).stackIndex,
      children: [
        TasksList(),
        TasksEntry()
      ],
    );
  }
}
