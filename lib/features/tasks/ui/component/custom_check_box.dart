import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  CustomCheckbox({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24.0,
      height: 24.0,
      decoration: BoxDecoration(
        border:  !value ? Border.all(color: Get.theme.colorScheme.onSurfaceVariant, width: 1.0 ): null,
        color: value ? Colors.green : Colors.transparent,
        borderRadius: BorderRadius.circular(4),
           boxShadow: value ? [
              BoxShadow(
               color: Get.theme.colorScheme.onSurfaceVariant.withOpacity(0.5),
               spreadRadius: 0.2,
               blurRadius: 6,
               offset: Offset(1, 1),
             )
           ] : [],
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon:
        Icon(CupertinoIcons.check_mark,size: 30, color: value ? Colors.white : Colors.transparent),
        onPressed: () => onChanged?.call(!value),
      ),
    );
  }
}