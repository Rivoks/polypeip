import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_icons/polypeip_icons.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class CustomBottomBar extends StatelessWidget {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final double appBarHeight;
  final double appBarWidth;
  final double appBarBorderHeight;
  final double appBarIconHeight;

  CustomBottomBar(
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
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey[600],
            blurRadius: 10.0, // has the effect of softening the shadow
            spreadRadius: 1.3, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              2.5,
            ))
      ]),
    );
  }

  Widget buildIconsRow() {
    double rowHeight = this.appBarHeight * this.heightScreen -
        this.appBarBorderHeight * this.heightScreen;
    double iconSize = this.heightScreen * this.appBarIconHeight;

    return Container(
      height: rowHeight,
      width: this.appBarWidth * this.widthScreen,
      color: CustomText.textColor(FontColor.blue),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
              iconSize: iconSize,
              color: CustomText.textColor(FontColor.white),
              icon: Icon(Polypeip.home),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/home");
              }),
          IconButton(
              iconSize: iconSize,
              color: CustomText.textColor(FontColor.white),
              icon: Icon(FontAwesome.calendar),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/events");
              }),
          IconButton(
              iconSize: iconSize,
              color: CustomText.textColor(FontColor.white),
              icon: Icon(FontAwesome.mail_alt),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/message");
              }),
          IconButton(
              iconSize: iconSize,
              color: CustomText.textColor(FontColor.white),
              icon: Icon(FontAwesome.info_circled),
              onPressed: () {
                Navigator.pushReplacementNamed(context, "/info");
              }),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: this.heightScreen * this.appBarHeight,
        width: this.widthScreen * this.appBarWidth,
        child: Column(
          children: <Widget>[buildTopBorder(), buildIconsRow()],
        ));
  }
}
