import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pim_book/core/component/color_pallet_Component.dart';
import 'package:pim_book/features/reminders/application/reminders_ctrl.dart';
import '../../../../core/utils.dart';
import '../../domain/reminder.dart';
import 'package:intl/intl.dart';

class ReminderCard extends StatefulWidget {
  final Reminder reminder;
  final Function(bool) onExpansionChanged;
  final RemindersController ctrl;

  ReminderCard({
    required this.reminder,
    required this.onExpansionChanged,
    required this.ctrl,
  });

  @override
  State<ReminderCard> createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final time = TimeOfDay.fromDateTime(DateTime.fromMillisecondsSinceEpoch(widget.reminder.time));

    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Set the border radius
        color: Get.theme.colorScheme.surfaceVariant,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0), // Set the border radius
          color: !Get.isDarkMode ? Utils.colorFromString(widget.reminder.color) : Utils.colorFromString(widget.reminder.color).withOpacity(0.25),
        ),
        child: InkWell(
          onLongPress: (){
            _showDeleteBottomSheet(context);
          },
          borderRadius: BorderRadius.circular(12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionPanelList(
              expansionCallback: (_, isExpanded) {
                this.isExpanded = isExpanded;
                widget.onExpansionChanged.call(isExpanded);
                setState(() {});
              },
              elevation: 0.0,
              children: [
                ExpansionPanel(
                  backgroundColor: Colors.transparent,
                  isExpanded: isExpanded,
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      dense: true,
                      title: Text(
                        widget.reminder.title,
                        style: Get.textTheme.headlineSmall,
                      ),
                      subtitle: Text(
                        'Time: ${time.format(context)}',
                        style: Get.textTheme.bodySmall,
                      ),
                    );
                  },
                  body: Container(
                    padding: EdgeInsets.only(left: 9, right: 9,bottom: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(height: 8),
                        Text(
                          widget.reminder.description,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Date: ${DateFormat('MMMM dd, yyyy').format(DateTime.fromMillisecondsSinceEpoch(widget.reminder.date))}',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Text(
                          'Duration: ${widget.reminder.duration} minutes',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteBottomSheet(BuildContext context) {
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
                'Delete',
                style: Get.textTheme.headlineMedium,
              ),
              SizedBox(height: 16),
              Text(
                '${widget.reminder.title}',
                style: Get.textTheme.titleMedium,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Get.back(); // Close the BottomSheet
                  // Perform the delete operation here
                  widget.ctrl.deleteThisReminder(widget.reminder);
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