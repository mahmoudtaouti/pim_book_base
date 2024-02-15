import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum ColorPalletPosition{
  above,
  under
}

class ColorPallet extends StatelessWidget {
  final Function(Color) onSelectColor;
  final Offset offset;
  final ColorPalletPosition position;

  ColorPallet({required this.onSelectColor, required this.offset,required this.position});

  @override
  Widget build(BuildContext context) {
    double overlayPosition = offset.dy;

    switch(position){
      case ColorPalletPosition.under:{
        overlayPosition += 80;
        break;
      }
      case ColorPalletPosition.above:{
        overlayPosition -= 100 ;
        break;
      }
    }
    return Material(
      color: Colors.transparent,
      child: Stack(
        alignment: Alignment.center,
          children: [
        Positioned(
          top: overlayPosition,
          left: 9,
          right: 9,
          child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.surface,
              borderRadius: BorderRadius.circular(9),
              boxShadow: [
                BoxShadow(
                  color: Get.theme.colorScheme.onSurfaceVariant.withOpacity(
                      0.3),
                  spreadRadius: 0.2,
                  blurRadius: 6,
                  offset: Offset(1, 1),
                )
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                alignment: WrapAlignment.center,
                crossAxisAlignment: WrapCrossAlignment.center,
                runAlignment: WrapAlignment.center,
                children: <Widget>[
                  for (final color in CardColor.colorsLight)
                    GestureDetector(
                      onTap: () {
                        onSelectColor(color);
                      },
                      child: Container(
                        width: 45,
                        height: 45,
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }

  static Future<Color?> showColorPallet(
      {required BuildContext context, required GlobalKey buttonKey,required ColorPalletPosition colorPalletPosition}) async {

    final overlay = Overlay.of(context);
    final Completer<Color?> completer = Completer<Color?>();
    OverlayEntry? overlayEntry;

    RenderBox renderBox = buttonKey.currentContext!.findRenderObject() as RenderBox;
    Offset buttonPosition = renderBox.localToGlobal(Offset.zero);

    overlayEntry = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: () {
          completer.complete(null); // Complete with null when tapped outside
          overlayEntry!.remove();
        },
        child: ColorPallet(
          onSelectColor: (color) {
            completer.complete(color);
            overlayEntry!.remove();
          },
          offset: buttonPosition,
          position: colorPalletPosition,
        ),
      ),
    );

    overlay.insert(overlayEntry);

    return completer.future;
  }
}


class CardColor {

  static final List<Color> colorsLight = [
    Colors.lightGreen.shade100,
    Colors.amber.shade100,
    Colors.deepOrange.shade100,
    Colors.redAccent.shade100,
    Colors.lightBlue.shade100,
    Colors.pink.shade100,

    Colors.blueGrey.shade100,
    Colors.yellow.shade100,
    Colors.teal.shade100,
    Colors.brown.shade100,
  ];

  static final List<Color> colorsDark = [
    Colors.green.shade800.withOpacity(0.2),
    Colors.amber.shade800.withOpacity(0.2),
    Colors.deepOrange.shade800.withOpacity(0.2),
    Colors.red.shade800.withOpacity(0.2),
    Colors.blue.shade800.withOpacity(0.2),
    Colors.pink.shade800.withOpacity(0.2),

    Colors.blueGrey.shade800.withOpacity(0.2),
    Colors.yellow.shade800.withOpacity(0.2),
    Colors.teal.shade800.withOpacity(0.2),
    Colors.brown.shade800.withOpacity(0.2),
  ];


  static Color getDarkerColorOf(Color color){
    try{
      var index = colorsLight.indexOf(color);
      return colorsDark[index];
    }catch (e){
      debugPrint('not supported color!! return the same color');
      return color;
    }
  }

}