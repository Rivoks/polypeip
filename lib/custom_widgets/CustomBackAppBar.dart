import 'package:flutter/material.dart';

class CustomBackAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final double appBarHeight;
  final double appBarWidth;
  final Color backgroundColor;

  CustomBackAppBar({
    @required this.context,
    @required this.heightScreen,
    @required this.widthScreen,
    this.appBarHeight = 0.082,
    this.appBarWidth = 1.0,
    this.backgroundColor = const Color(0xff20b6ef),
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: this.backgroundColor,
      automaticallyImplyLeading: true,
      centerTitle: true,
    );
  }

  Size get preferredSize =>
      Size(widthScreen * appBarWidth, heightScreen * appBarHeight);
}
