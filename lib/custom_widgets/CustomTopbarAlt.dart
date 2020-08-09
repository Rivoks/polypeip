import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTopbarAlt extends StatelessWidget {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final double appBarHeight;
  final Widget topBarChild;

  CustomTopbarAlt({
    @required this.context,
    @required this.heightScreen,
    @required this.widthScreen,
    @required this.appBarHeight,
    @required this.topBarChild,
  });

  @override
  Widget build(BuildContext context) {
    double topBarHeight = heightScreen * appBarHeight;
    return Container(
      alignment: Alignment.center,
      width: widthScreen,
      height: topBarHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300],
            width: 1.5,
          ),
        ),
      ),
      child: topBarChild,
    );
  }
}
