import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pim_book/features/appointments/domain/appointment.dart';

class AppointmentsEntryController extends GetxController{

  AppointmentsEntryController(){
    entityBeingEdited = Appointment();
  }

  var entityBeingEdited;
  RxString _chosenDate = "".obs;
  RxString _apptTime= "".obs;

  set apptTime(String? value) {
    _apptTime.value = value!;
    update();
  }
  String? get apptTime => _apptTime.value;


  String? get chosenDate => _chosenDate.value;
  set chosenDate(String? value) {
    _chosenDate.value = value!;
    update();
  }


}