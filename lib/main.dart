import 'package:flutter/material.dart';
import 'package:pim_book/core/data/pim_db.dart';

import 'features/home/ui/pim_home.dart';

void main() async{
  await PIMdb.instance.init();
  runApp(PIMBook());
}