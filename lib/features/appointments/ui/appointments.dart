import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:pim_book/features/appointments/controller/appointments_controller.dart';
import 'package:pim_book/features/appointments/controller/appointments_entry_controller.dart';
import 'package:pim_book/features/appointments/controller/appointments_list_controller.dart';
import 'package:pim_book/features/appointments/ui/appointments_entry.dart';
import 'package:pim_book/features/appointments/ui/appointments_list.dart';

class Appointments extends StatelessWidget {
  Appointments({Key? key}) : super(key: key);

  final AppointmentsController appointmentsCtrl = Get.put(AppointmentsController());


  @override
  Widget build(BuildContext context) {
    return Obx(()=> IndexedStack(
      index: appointmentsCtrl.stackIndex,
      children: [
        AppointmentsList(appointmentsCtrl),
        AppointmentsEntry(appointmentsCtrl)
      ],
    )) ;
  }
}
