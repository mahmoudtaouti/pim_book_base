import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Utils{

  static final initDate = DateTime(0);

  Utils._();
  static Directory? _docsDir;

  static Future<Directory> get docsDir async {
    if (_docsDir == null) {
      _docsDir =  await getApplicationDocumentsDirectory();
    }
    return _docsDir!;
  }

  static bool areDatesEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// validate datetime so it's not an initial datetime (case: datetime not selected)
  static bool isDateValid(DateTime dateTime){
    return initDate.millisecondsSinceEpoch != dateTime.millisecondsSinceEpoch;
  }

}




// Future selectTime(BuildContext context,RemindersModel model) async{
//   TimeOfDay initialTime = TimeOfDay.now();
//   if (model.entityBeingEdited.time != null) {
//     initialTime = timeOfDayFromString(model.entityBeingEdited.time!);
//   }
//   TimeOfDay? picked = await showTimePicker(context: context, initialTime: initialTime);
//   if (picked != null) {
//     model.entityBeingEdited.time = "${picked.hour},${picked.minute}";
//     model.apptTime = picked.format(context);
//     return "${picked.hour},${picked.minute}";
//   }
// }


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
