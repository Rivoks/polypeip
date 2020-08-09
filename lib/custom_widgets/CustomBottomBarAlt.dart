import 'package:flutter/material.dart';

class CustomBottomBarAlt extends StatelessWidget {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final double appBarHeight;
  final double appBarWidth;
  final double appBarBorderHeight;
  final double appBarIconHeight;

  CustomBottomBarAlt(
      {@required this.context,
      @required this.heightScreen,
      @required this.widthScreen,
      this.appBarHeight = 0.08,
      this.appBarWidth = 1.0,
      this.appBarBorderHeight = 0.002,
      this.appBarIconHeight = 0.04});

  Widget buildTopBorder() {
    return Container(
      height: this.appBarBorderHeight * this.heightScreen,
      width: this.appBarWidth * this.widthScreen,
    );
  }

  Widget buildIconsRow() {
    return Container(
      height: 0,
      width: this.appBarWidth * this.widthScreen,
      color: Colors.transparent,
      alignment: Alignment.center,
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.heightScreen * 0.04,
        width: this.widthScreen * this.appBarWidth,
        child: Column(
          children: <Widget>[buildTopBorder(), buildIconsRow()],
        ));
  }
}
