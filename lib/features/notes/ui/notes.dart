import 'package:flutter/material.dart';

class Notes extends StatefulWidget {

  @override
  _NotesState createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  @override
  Widget build(BuildContext context) {
    return  IndexedStack(
      index: 0,
      children: [
        Container(color: Colors.brown,),
        Container(color: Colors.blueGrey,),
      ],
    );
  }
}
