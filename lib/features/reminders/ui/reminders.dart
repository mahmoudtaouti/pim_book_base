import 'package:flutter/material.dart';
import 'package:pim_book/features/reminders/ui/new_reminder_screen.dart';
import 'package:get/get.dart';
import '../../../core/theme/pim_icons.dart';
class Appointments extends StatelessWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=> Get.to(NewReminderScreen()),
        label: Text('New Note'),
        icon: PIMIcons.fromAsset(iconName: PIMIcons.document_text,color: Get.theme.colorScheme.onInverseSurface),
      ),
      body: Placeholder(),
    );
  }
}
