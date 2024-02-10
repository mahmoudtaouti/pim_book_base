import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pim_book/core/theme/color_themes.dart';

class PIMIcons {

  PIMIcons._();
  static const String _iconsPath = 'assets/svg/linear_icons';

  static const String settings = 'setting-31.svg';
  static const String note = 'note1.svg';
  static const String document_text = 'document-text1.svg';
  static const String calendar = 'calendar1.svg';

  static const String document = 'document1.svg';
  static const String task_square = 'task-square.svg';
  static const String document_normal = 'document-normal.svg';
  static const String fatrows = 'fatrows.svg';
  static const String star = 'star.svg';
  static const String edit = 'edit-21.svg';
  static const String calendar_add = 'calendar-add1.svg';
  static const String add_square = 'add-square1.svg';
  static const String text_bold = 'cd.svg';
  static const String quote_down = 'quote-down.svg';
  static const String clock = 'clock1.svg';
  static const String timer_start = 'timer_start.svg';
  static const String brush = 'brush.svg';

  static Widget fromAsset({required iconName,double size = 24, Color color = ColorThemes.primarySwatch}) {
    return SvgPicture.asset(
      '$_iconsPath/$iconName',
      width: size,
      height: size,
      color: color,
    );
  }

}
