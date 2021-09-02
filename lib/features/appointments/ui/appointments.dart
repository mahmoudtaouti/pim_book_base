import 'package:flutter/material.dart';
import 'package:pim_book/features/appointments/domain/appointments_model.dart';
import 'package:pim_book/features/appointments/ui/appointments_entry.dart';
import 'package:pim_book/features/appointments/ui/appointments_list.dart';
import 'package:provider/provider.dart';
class Appointments extends StatelessWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: Provider.of<AppointmentsModel>(context).stackIndex,
      children: [
        AppointmentsList(),
        AppointmentsEntry()
      ],
    );
  }
}
