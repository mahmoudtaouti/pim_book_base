import 'package:flutter/material.dart';

class DismissibleListItem extends StatelessWidget {
  final String title;
  final VoidCallback onDismissed;

  DismissibleListItem({required this.title, required this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.red,
        child: Align(
          alignment: Alignment.centerRight,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      onDismissed: (_) => onDismissed(),
      child: ListTile(
        title: Text(title),
        // Add other ListTile properties as needed
      ),
    );
  }
}
