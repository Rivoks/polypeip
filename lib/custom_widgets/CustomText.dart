import 'package:flutter/material.dart';

enum FontOpacity { max, medium, min, none }

enum FontColor { blue, yellow, white, black, lightGrey, darkGrey, grey }

enum FontSize { xs, sm, md, lg, xl }

class CustomText extends StatelessWidget {
  final String text;
  final FontColor fontColor;
  final FontSize fontSize;
  final FontOpacity fontOpacity;
  final FontWeight fontWeight;
  final TextAlign alignment;
  final int maxLines;
  final bool underline;
  final bool uppercase;
  final TextOverflow overflowStyle;

  CustomText(
      {@required this.text,
      @required this.fontColor,
      @required this.fontSize,
      this.fontOpacity = FontOpacity.none,
      this.fontWeight = FontWeight.normal,
      this.alignment = TextAlign.start,
      this.maxLines = 2,
      this.underline = false,
      this.uppercase = false,
      this.overflowStyle = TextOverflow.ellipsis});

  static double textSize(FontSize fontSize) {
    double size;
    switch (fontSize) {
      case FontSize.xs:
        size = 12;
        break;
      case FontSize.sm:
        size = 14;
        break;
      case FontSize.md:
        size = 16;
        break;
      case FontSize.lg:
        size = 20;
        break;
      case FontSize.xl:
        size = 24;
        break;
    }
    return size;
  }

  static Color textColor(FontColor fontColor) {
    Color color;
    switch (fontColor) {
      case FontColor.blue:
        color = Color(0xff00adef);
        break;
      case FontColor.yellow:
        color = Color(0xffffd675);
        break;
      case FontColor.lightGrey:
        color = Colors.grey[300];
        break;
      case FontColor.grey:
        color = Colors.grey[500];
        break;
      case FontColor.darkGrey:
        color = Colors.grey[700];
        break;
      case FontColor.black:
        color = Colors.black;
        break;
      case FontColor.white:
        color = Colors.white;
        break;
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    return new Text(uppercase ? this.text.toUpperCase() : this.text,
        maxLines: this.maxLines,
        textAlign: this.alignment,
        overflow: this.overflowStyle,
        style: TextStyle(
          decoration:
              underline ? TextDecoration.underline : TextDecoration.none,
          fontSize: textSize(this.fontSize),
          color: textColor(this.fontColor),
          fontWeight: this.fontWeight,
        ));
  }
}
