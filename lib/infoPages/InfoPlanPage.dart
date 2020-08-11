import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class InfoPlanPage extends StatefulWidget {
  @override
  _InfoPlanPageState createState() => _InfoPlanPageState();
}

class _InfoPlanPageState extends State<InfoPlanPage> {
  Widget buildImageMap(height, width) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Container(
        alignment: Alignment.center,
        child: Text("Image du plan de la fac"),
        color: Colors.grey,
        height: height * 0.6,
      ),
    );
  }

  Widget buildTopContent(height, width) {
    return Container(
      width: width,
      color: CustomText.textColor(FontColor.blue),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        child: Column(
          children: <Widget>[
            Icon(
              FontAwesome.map_1,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "Plan de Jussieu",
              fontColor: FontColor.white,
              fontSize: FontSize.lg,
              uppercase: true,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.4, 0.4],
          colors: [CustomText.textColor(FontColor.lightBlue), Colors.white],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomBackAppBar(
              context: this.context,
              heightScreen: _screenHeight,
              widthScreen: _screenWidth),
          body: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildTopContent(_screenHeight, _screenWidth),
              buildImageMap(_screenHeight, _screenWidth),
              Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05)),
            ],
          )),
        ),
      ),
    );
  }
}
