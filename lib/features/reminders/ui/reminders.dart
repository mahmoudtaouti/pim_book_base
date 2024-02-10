import 'package:flutter/material.dart';
class Appointments extends StatelessWidget {
  const Appointments({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: 0,
      children: [
        Container(color: Colors.yellow,),
        Container(color: Colors.blueGrey,),
      ],
    );
  }
}
