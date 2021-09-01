import 'package:pim_book/core/base_model.dart';

import 'appointment.dart';

AppointmentsModel appointmentsModel = AppointmentsModel();

class AppointmentsModel extends BaseModel{

  String? _apptTime;

  AppointmentsModel(){
    entityBeingEdited = Appointment();
  }

  set apptTime(String? value) {
    _apptTime = value;
    notifyListeners();
  }
  String? get apptTime => _apptTime;
}