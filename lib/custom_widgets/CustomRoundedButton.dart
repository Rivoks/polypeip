import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class CustomRoundedButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final FontColor fontColor;
  final FontSize fontSize;
  final FontWeight fontWeight;
  final Color backgroundColor;
  final Color borderColor;
  final void Function() onPressed;
  final double buttonWidth;
  final double buttonHeight;
  final double screenHeight;
  final double screenWidth;

  CustomRoundedButton({
    @required this.screenHeight,
    @required this.screenWidth,
    @required this.buttonHeight,
    @required this.buttonWidth,
    @required this.text,
    @required this.fontColor,
    @required this.backgroundColor,
    @required this.borderColor,
    @required this.onPressed,
    this.fontWeight = FontWeight.normal,
    this.fontSize = FontSize.md,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> listWidget = [];

    if (this.icon != null) {
      listWidget.add(Container(
          padding: EdgeInsetsDirectional.only(end: this.screenWidth * 0.02),
          child: Icon(
            this.icon,
            size: CustomText.textSize(this.fontSize),
            color: CustomText.textColor(this.fontColor),
          )));
    }

    listWidget.add(Container(
        child: CustomText(
      text: this.text,
      fontColor: this.fontColor,
      fontSize: this.fontSize,
      fontWeight: this.fontWeight,
    )));

    return GestureDetector(
        onTap: this.onPressed,
        child: Container(
          // width: this.screenWidth * this.buttonWidth,
          decoration: BoxDecoration(
              color: this.backgroundColor,
              borderRadius: new BorderRadius.all(const Radius.circular(500)),
              border: Border.all(
                color: this.borderColor,
                width: 2,
              )),
          padding: EdgeInsets.symmetric(
              vertical: this.screenWidth * this.buttonHeight),
          margin: EdgeInsets.symmetric(
              horizontal: this.screenWidth * this.buttonWidth),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: listWidget),
        ));
  }
}
