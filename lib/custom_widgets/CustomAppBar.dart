import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final BuildContext context;
  final double heightScreen;
  final double widthScreen;
  final double appBarHeight;
  final double appBarWidth;
  final double appBarLogoHeight;
  final double appBarIconHeight;

  CustomAppBar({

    @required this.context,
    @required this.heightScreen,
    @required this.widthScreen,
    this.appBarHeight = 0.082,
    this.appBarWidth = 1.0,
    this.appBarLogoHeight = 0.065,
    this.appBarIconHeight = 0.035,
  });

  @override
  Widget build(BuildContext context) {

    double logoSize = this.heightScreen * this.appBarLogoHeight;
    double iconSize = this.heightScreen * this.appBarIconHeight;

    return AppBar(

      automaticallyImplyLeading: true,
      backgroundColor: CustomText.textColor(FontColor.blue),
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.only(left: this.widthScreen * 0.05),
        child: Image.asset(
          "assets/img/appbar-logo.png",
          height: logoSize,
        )
      ),
      actions: <Widget>[
        IconButton(
          padding: EdgeInsets.only(right: this.widthScreen * 0.1),
          icon: Icon(Icons.settings, size: iconSize, color: Colors.white,), 
          onPressed: () {
            Navigator.pushNamed(context, "/settings");
          }
        )
      ],
    );
  }

  Size get preferredSize => Size(widthScreen * appBarWidth, heightScreen * appBarHeight);

}