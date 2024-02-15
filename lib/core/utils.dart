import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class Utils {
  static final initDate = DateTime(0);

  Utils._();
  static Directory? _docsDir;

  static Future<Directory> get docsDir async {
    if (_docsDir == null) {
      _docsDir = await getApplicationDocumentsDirectory();
    }
    return _docsDir!;
  }

  static bool areDatesEqual(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  /// validate datetime so it's not an initial datetime (case: datetime not selected)
  static bool isDateValid(DateTime dateTime) {
    return initDate.millisecondsSinceEpoch != dateTime.millisecondsSinceEpoch;
  }

  static String colorToString(Color color) {
    return '#${color.value.toRadixString(16).padLeft(8, '0')}';
  }

  static Color colorFromString(String colorString) {
    if (colorString.startsWith('#') && colorString.length == 9) {
      // Remove '#' and parse the color value
      int colorValue = int.parse(colorString.substring(1), radix: 16);
      return Color(colorValue);
    } else {
      throw ArgumentError('Invalid color string: $colorString');
    }
  }


  /// [durationFormatText] format a duration from minutes value to formal text
  static String durationFormatText(int duration) {
    String durationText;
    if (duration >= 60) {
      int hours = duration ~/ 60;
      int minutes = duration % 60;
      durationText = '$hours h ${minutes != 0 ? minutes : ''}';
    } else {
      durationText = '$duration minutes';
    }
    return durationText;
  }

  /// [dayOfTimeFromValueFormat] format a DateTime from Milliseconds value to formal text Time of day
  static String dayOfTimeFromValueFormat(int value) {
    return DateFormat.jm().format(DateTime.fromMillisecondsSinceEpoch(value));
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

DateTime dateTimeFromString(String dateString) {
  List dateParts = dateString.split(',');
  return DateTime(
    int.parse(dateParts[0]),
    int.parse(dateParts[1]),
    int.parse(dateParts[2]),
  );
}

TimeOfDay timeOfDayFromString(String timeString) {
  List dateParts = timeString.split(',');
  return TimeOfDay(
    hour: int.parse(dateParts[0]),
    minute: int.parse(dateParts[1]),
  );
}

Color shadeColor(int value, int percent, int alpha) {
  String color = value.toRadixString(16);

  var R = color.substring(2, 4);
  var G = color.substring(4, 6);
  var B = color.substring(6, 8);

  int r = int.parse(R, radix: 16);
  int g = int.parse(R, radix: 16);
  int b = int.parse(R, radix: 16);

  num pr = r - percent;
  num pg = g - percent;
  num pb = b - percent;

  int cp = pr > 255 ? 255 : pr.toInt();
  int cg = pg > 255 ? 255 : pg.toInt();
  int cb = pb > 255 ? 255 : pg.toInt();

  R = cp.toRadixString(16);
  G = cg.toRadixString(16);
  B = cb.toRadixString(16);

  String shadeColor = "0x" + R + G + B;

  return Color.fromARGB(alpha, cp, cg, cb);
}
