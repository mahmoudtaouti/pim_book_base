import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/features/reminders/application/reminders_ctrl.dart';
import 'package:pim_book/features/reminders/data/reminders_db_worker.dart';

import '../../../core/utils.dart';
import '../domain/reminder.dart';

class ReminderContentController extends GetxController {
  RemindersDBWorker remindersDBWorker = RemindersDBWorker();

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final _selectedColor = Utils.colorToString(Colors.transparent).obs;
  final _selectedDate = 0.obs;
  final selectedTime = 0.obs;
  final selectedDuration = 0.obs;

  Reminder? _reminderData;

  ReminderContentController({Reminder? reminderData})  {
    _reminderData = reminderData;
  }

  @override
  void onInit() {
    if (_reminderData != null) {
      _loadReminder();
    }else{
      this._selectedDate.value = Get.find<RemindersController>().selectedDate.millisecondsSinceEpoch;
    }
    super.onInit();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  _loadReminder() {
    titleController.text = this._reminderData!.title;
    titleController.text = this._reminderData!.title;
    _selectedColor.value = this._reminderData!.color;
    _selectedDate.value = this._reminderData!.date;
    selectedTime.value = this._reminderData!.time;
    selectedDuration.value = this._reminderData!.duration;
  }

  Future<void> _updateReminder() async{
    int timeNow = DateTime.now().millisecondsSinceEpoch;
    String title = titleController.text;
    String description = descriptionController.text;
    String color = _selectedColor.value;
    int date = _selectedDate.value;
    int time = selectedTime.value;
    int duration = selectedDuration.value;
    int dateCreated =
        _reminderData != null ? _reminderData!.dateCreated : timeNow;
    int dateEdited = timeNow;

    if (this._reminderData == null) {
      this._reminderData = Reminder(
          title: title,
          description: description,
          color: color,
          date: date,
          time: time,
          duration: duration,
          dateCreated: dateCreated,
          dateEdited: dateEdited);
      this._reminderData!.isValid().fold((l) => null,
          (r) async => await remindersDBWorker.create(this._reminderData!));
    } else {
      this._reminderData!.isValid().fold(
          (l) => null,
          (r) async =>
              await remindersDBWorker.update(this._reminderData!.updateData(
                    title: title,
                    description: description,
                    color: color,
                    date: date,
                    time: time,
                    duration: duration,
                    dateEdited: dateEdited,
                  )));
    }
    Get.find<RemindersController>().fetchData();
  }

  saveReminder() async {
    await _updateReminder();
    Get.back();
  }

  setColor(Color color){
    _selectedColor.value = Utils.colorToString(color);
  }

  Color get selectedColor => Utils.colorFromString(_selectedColor.value);

  Color? get scaffoldBackgroundColor {
    if (_selectedColor.value != Utils.colorToString(Colors.transparent)) {
      Color tColor = Utils.colorFromString(_selectedColor.value);
      if (Get.isDarkMode) {
        return tColor.withOpacity(0.3);
      } else {
        return tColor;
      }
    }
    return null;
  }
}
