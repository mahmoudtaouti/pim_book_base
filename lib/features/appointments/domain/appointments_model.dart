import 'package:pim_book/core/base_model.dart';
import 'package:pim_book/features/appointments/data/appointments_db_worker.dart';

import 'appointment.dart';

class AppointmentsModel extends BaseModel{

  String? _apptTime;

  AppointmentsModel(){
    entityBeingEdited = Appointment();
    loadData("appointments", AppointmentsDBWorker.instance);
  }

  set apptTime(String? value) {
    _apptTime = value;
    notifyListeners();
  }
  String? get apptTime => _apptTime;
}