import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:developer';
import 'package:path/path.dart' as Path;
import 'package:permission_handler/permission_handler.dart';


class Utils{

  Utils._();
  static Directory? _docsDir;
  static Directory? _tempDir;
  static Directory? _extDir;
  static Directory? _appDir;

  static Future<Directory> get extDir async {
    if (_extDir == null) {
      _extDir =  await getExternalStorageDirectory();
    }
    return _extDir!;
  }

  static Future<Directory> get tempDir async {
    if (_tempDir == null) {
      _tempDir =  await getTemporaryDirectory();
    }
    return _tempDir!;
  }

  static Future<Directory> get docsDir async {
    if (_docsDir == null) {
      _docsDir =  await getApplicationDocumentsDirectory();
    }
    return _docsDir!;
  }



  static Future<Directory> get appDir async {
    if (_appDir == null) {
      _appDir =  await _createDirectory();
    }
    return _docsDir!;
  }



  static Future<bool> _requestFilePermission() async {
    PermissionStatus result;
    // In Android we need to request the storage permission,
    // while in iOS is the photos permission
    if (Platform.isAndroid) {
      result = await Permission.storage.request();

      if (result.isGranted) {
        return true;
      }
    }
    //TODO manage other platforms

    return false;
  }

  static Future<Directory> _createDirectory() async {
    await _requestFilePermission();
    Directory dir = await extDir;
    String _appDocDir = '';
    var values = dir.path.split("${Platform.pathSeparator}");
    var dim = values.length - 4;
    for (var i = 0; i < dim; i++) {
      _appDocDir += values[i];
      _appDocDir += "${Platform.pathSeparator}";
    }
    _appDocDir += 'PIMBook';
    print(_appDocDir);

    return Directory(_appDocDir).create(recursive: true);
  }


  //TODO initDate parameters
  static Future selectDate(BuildContext inContext,String? chosenDate) async {
    DateTime initDate = DateTime.now();
    if (chosenDate != null && chosenDate.isNotEmpty) {//todo validate chosenDate
      initDate = dateTimeFromString(chosenDate);
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


  static String getNowDateStringFormat(){
    DateTime nowTime = DateTime.now();
    return "${nowTime.year},${nowTime.month},${nowTime.day}";
  }

  static String getNowTimeStringFormat(){
    TimeOfDay nowTime = TimeOfDay.now();
    return "${nowTime.hour},${nowTime.minute}";
  }

  static Future selectTime(BuildContext context,String? apptTime) async{
    TimeOfDay initialTime = TimeOfDay.now();
    if (apptTime != null && apptTime.isNotEmpty) {//todo validate apptTime
      initialTime = timeOfDayFromString(apptTime);
    }
    TimeOfDay? picked = await showTimePicker(context: context, initialTime: initialTime);
    if (picked != null) {
      apptTime = "${picked.hour},${picked.minute}";
      apptTime = picked.format(context);
      return "${picked.hour},${picked.minute}";
    }
  }

  /// format year,month,day
  static DateTime dateTimeFromString(String dateString){
    List dateParts = dateString.split(',');
    return DateTime(
      int.parse(dateParts[0]),
      int.parse(dateParts[1]),
      int.parse(dateParts[2]),
    );
  }

  /// time format hour,minute
  static TimeOfDay timeOfDayFromString(String timeString){
    List dateParts = timeString.split(',');
    return TimeOfDay(
      hour: int.parse(dateParts[0]),
      minute: int.parse(dateParts[1]),
    );
  }

  /// change color contrast
  static Color shadeColor(int value,int percent,int alpha) {

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

}













