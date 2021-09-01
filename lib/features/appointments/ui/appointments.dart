// import 'package:flutter/material.dart';
// import 'package:pim_book/features/appointments/domain/appointments_model.dart';
// import 'package:pim_book/features/appointments/ui/appointments_entry.dart';
// import 'package:pim_book/features/appointments/ui/appointments_list.dart';
// import 'package:scoped_model/scoped_model.dart';
// class Appointments extends StatelessWidget {
//   const Appointments({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ScopedModel<AppointmentsModel>(
//         model: appointmentsModel,
//         child: ScopedModelDescendant<AppointmentsModel>(
//           builder: (BuildContext context,Widget? child,AppointmentsModel model)=>
//               IndexedStack(
//                 index: model.stackIndex,
//                 children: [
//                   AppointmentsList(),
//                   AppointmentsEntry()
//                 ],
//               ),
//         ));
//   }
// }
