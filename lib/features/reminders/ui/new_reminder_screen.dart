import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/core/theme/pim_icons.dart';
import '../../../core/component/color_pallet_Component.dart';
import '../../../core/utils.dart';
import '../application/new_reminder_ctrl.dart';


class NewReminderScreen extends StatelessWidget {

  final ctrl = Get.put(ReminderContentController());
  final chooseColorButtonKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    TimeOfDay? time;
    int? duration;
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
          title: Text('New Reminder'),
          actions: [
            IconButton(
              key: chooseColorButtonKey,
              onPressed: () async {
                Color? sColor = await ColorPallet.showColorPallet(
                    context: context,
                    buttonKey: chooseColorButtonKey,
                    colorPalletPosition: ColorPalletPosition.under,
                );
                if (sColor != null) {
                  ctrl.setColor(sColor);
                }
              },
              icon: PIMIcons.fromAsset(iconName: PIMIcons.brush, color: Get.iconColor!),
            ),
          ],
        ),
        backgroundColor: ctrl.scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: ctrl.titleController,
                style: Get.textTheme.headlineSmall,
                decoration: InputDecoration(
                  icon: PIMIcons.fromAsset(
                      iconName: PIMIcons.edit, color: Get.iconColor!, size: 32),
                  alignLabelWithHint: false,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none),
                  hintText: 'Title.',
                ),
              ),
              SizedBox(height: 16),
              TextField(
                controller: ctrl.descriptionController,
                decoration: InputDecoration(
                  hintText: 'Description...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                maxLines: 3,
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Obx(() {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  FloatingActionButton.extended(
                    heroTag: 'select_time',
                    backgroundColor: Get.theme.colorScheme.surfaceVariant,
                    isExtended: ctrl.selectedTime.value != 0,
                    extendedPadding: EdgeInsets.symmetric(
                        vertical: 7, horizontal: 15),
                    extendedTextStyle: Get.textTheme.bodySmall,
                    icon: PIMIcons.fromAsset(
                        iconName: PIMIcons.clock,
                        size: 24,
                        color: Get.iconColor!),
                    label: GestureDetector(
                      onLongPress: () {
                        ctrl.selectedTime.value = 0;
                      },
                      child: Text('${Utils.dayOfTimeFromValueFormat(
                          ctrl.selectedTime.value)}'),
                    ),
                    onPressed: () async {
                      time = await _selectTime(
                          context: context, selectedValue: time);
                      if (time != null) {
                        ctrl.selectedTime.value =
                            DateTime(0, 0, 0, time!.hour, time!.minute,)
                                .millisecondsSinceEpoch;
                      }
                    },
                  ),
                  SizedBox(width: 13),
                  FloatingActionButton.extended(
                    heroTag: 'select_duration',
                    backgroundColor: Get.theme.colorScheme.surfaceVariant,
                    isExtended: ctrl.selectedDuration.value != 0,
                    extendedPadding: EdgeInsets.symmetric(
                        vertical: 7, horizontal: 15),
                    extendedTextStyle: Get.textTheme.bodySmall,
                    icon: PIMIcons.fromAsset(
                        iconName: PIMIcons.timer,
                        size: 24,
                        color: Get.iconColor!),
                    label: GestureDetector(
                      onLongPress: () {
                        ctrl.selectedDuration.value = 0;
                      },
                      child: Text(
                          '${Utils.durationFormatText(
                              ctrl.selectedDuration.value)} '
                      ),
                    ),
                    onPressed: () async {
                      duration = await _selectDuration(
                          context: context, selectedValue: duration);
                      if (duration != null) {
                        ctrl.selectedDuration.value = duration!;
                      }
                    },
                  ),
                ],
              ),
              SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(7.0),
                child: FloatingActionButton(
                  backgroundColor: Get.theme.colorScheme.tertiaryContainer,
                  foregroundColor: Get.theme.colorScheme.onTertiaryContainer,
                  child: Icon(
                    Icons.check,
                    size: 34,
                  ),
                  onPressed: () {
                    ctrl.saveReminder();
                  },
                ),
              ),
            ],
          );
        }),
      );
    });
  }

  Future<TimeOfDay?> _selectTime(
      {required BuildContext context, TimeOfDay? selectedValue}) async {
    TimeOfDay time = selectedValue ?? TimeOfDay(hour: 0, minute: 0);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: time,
    );
    return picked;
  }

  Future<int?> _selectDuration(
      {required BuildContext context, int? selectedValue}) async {
    int? selectedDuration = selectedValue;
    await showDialog<int>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Duration'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text('duration of the event (optional):'),
                  SizedBox(height: 10),
                  DropdownButton<int>(
                    value: selectedDuration,
                    hint: Text('select'),
                    onChanged: (int? value) {
                      if (value != null) {
                        setState(() {
                          selectedDuration = value;
                        });
                      }
                    },
                    items: List.generate(30, (index) => (index + 1) * 5)
                        .map<DropdownMenuItem<int>>(
                          (int value) {
                        String durationText;

                        return DropdownMenuItem<int>(
                          value: value,
                          child: Text(Utils.durationFormatText(value)),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedDuration != null && selectedDuration != 0) {
                      Get.back();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please select a duration.'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
    return selectedDuration;
  }

}
