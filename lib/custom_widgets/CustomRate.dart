import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';

class CustomRate extends StatelessWidget {
  final double heightScreen;
  final double widthScreen;
  final double size;
  final Color color;
  final int rate;
  final MainAxisAlignment mainAxisAlignment;
  final double paddingVertial;

  final Function setRate;

  CustomRate({
    @required this.heightScreen,
    @required this.widthScreen,
    @required this.size,
    @required this.color,
    @required this.rate,
    @required this.setRate,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.paddingVertial = 0.02,
  });

  List<Widget> buildRate() {
    List<Widget> listWidget = [];

    for (int i = 0; i < 5; i++) {
      listWidget.add(GestureDetector(
        child: Padding(
            padding: EdgeInsets.only(right: this.widthScreen * 0.02),
            child: Icon(
              i < rate ? FontAwesome.star : FontAwesome.star_empty,
              color: this.color,
              size: this.heightScreen * this.size,
            )),
        onTap: () {
          if (setRate != null) {
            setRate((i + 1 == rate) ? 0 : i + 1);
          }
        },
      ));
    }

    return listWidget;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.symmetric(vertical: heightScreen * this.paddingVertial),
        child: Row(
          mainAxisAlignment: this.mainAxisAlignment,
          children: buildRate(),
        ));
  }
}
