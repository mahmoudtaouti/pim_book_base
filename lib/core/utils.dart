import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pim_book/features/appointments/controller/appointments_controller.dart';
import 'package:pim_book/features/appointments/domain/appointments_model.dart';
import 'base_model.dart';





class Utils{

  Utils._();
  static Directory? _docsDir;

  static Future<Directory> get docsDir async {
    if (_docsDir == null) {
      _docsDir =  await getApplicationDocumentsDirectory();
    }
    return _docsDir!;
  }

}



//TODO initDate parameters
Future selectDate(BuildContext inContext ,AppointmentsController ctrl) async {
  DateTime initDate = DateTime.now();
  if (ctrl.chosenDate != null) {
    initDate = dateTimeFromString(ctrl.chosenDate!);
  }

  DateTime? picked = await
      showDatePicker(
          context: inContext,
          initialDate: initDate,
          firstDate: DateTime(1900),
          lastDate: DateTime(2060)
      );
  if (picked != null) {
    //inModel.chosenDate = DateFormat.yMMMMd("en_US").format(picked.toLocal());
    return "${picked.year},${picked.month},${picked.day}";
  }

}

Future selectTime(BuildContext context,AppointmentsController ctrl) async{
  TimeOfDay initialTime = TimeOfDay.now();
  if (ctrl.entityBeingEdited.value.apptTime != null) {
    initialTime = timeOfDayFromString(ctrl.entityBeingEdited.value.apptTime!);
  }
  TimeOfDay? picked = await showTimePicker(context: context, initialTime: initialTime);
  if (picked != null) {
    ctrl.entityBeingEdited.value.apptTime = "${picked.hour},${picked.minute}";
    ctrl.apptTime = picked.format(context);
    return "${picked.hour},${picked.minute}";
  }
}


DateTime dateTimeFromString(String dateString){
  List dateParts = dateString.split(',');
  return DateTime(
    int.parse(dateParts[0]),
    int.parse(dateParts[1]),
    int.parse(dateParts[2]),
  );
}

TimeOfDay timeOfDayFromString(String timeString){
  List dateParts = timeString.split(',');
  return TimeOfDay(
    hour: int.parse(dateParts[0]),
    minute: int.parse(dateParts[1]),
  );
}

Color shadeColor(int value,int percent,int alpha) {


  String color = value.toRadixString(16);

  var R = color.substring(2,4);
  var G = color.substring(4,6);
  var B = color.substring(6,8);

  int r = int.parse(R , radix: 16);
  int g = int.parse(R , radix: 16);
  int b = int.parse(R , radix: 16);

  num pr = r - percent;
  num pg = g - percent;
  num pb = b - percent;

  int cp = pr > 255 ? 255 : pr.toInt();
  int cg = pg> 255 ? 255 : pg.toInt();
  int cb = pb > 255 ? 255 : pg.toInt();


  R = cp.toRadixString(16);
  G = cg.toInt().toRadixString(16);
  B = cb.toInt().toRadixString(16);

  String shadeColor =  "0x"+R+G+B;

  return Color.fromARGB(
    alpha,
    cp,
    cg,
    cb)
  ;

}
