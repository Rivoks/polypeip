import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/custom_widgets/CustomTextArea.dart';
import 'package:polypeip/infoPages/InfoGoodiesPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageWritePage extends StatefulWidget {
  MessageWritePage({@required this.messageId});

  final String messageId;

  @override
  _MessageWritePageState createState() => _MessageWritePageState();
}

class _MessageWritePageState extends State<MessageWritePage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget buildImageMap(height, width) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    Color blue = CustomText.textColor(FontColor.blue);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.08),
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.02),
          ),
          Icon(
            Icons.message,
            color: blue,
            size: _screenHeight * 0.08,
          ),
          Container(
            padding: EdgeInsets.only(top: _screenHeight * 0.02),
            child: CustomText(
              alignment: TextAlign.center,
              text: "Envoyer un message",
              fontColor: FontColor.blue,
              fontSize: FontSize.xl,
              fontWeight: FontWeight.bold,
              maxLines: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.06),
          ),
          CustomTextArea(
            heightScreen: _screenHeight,
            widthScreen: _screenWidth,
            inputColor: Colors.grey[800],
            borderColor: blue,
            placeHolder: "Titre de votre message",
            showSendIcon: false,
            maxLines: 1,
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.02)),
          CustomTextArea(
            heightScreen: _screenHeight,
            widthScreen: _screenWidth,
            inputColor: Colors.grey[800],
            borderColor: blue,
            placeHolder: "Écrivez votre message",
            showSendIcon: false,
            maxLines: null,
            inputType: TextInputAction.newline,
          )
        ],
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
              FontAwesome.lightbulb,
              size: height * 0.072,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "Envoyez nous vos idées !",
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

  Widget buildSubmitButton(height, width) {
    return Container(
        child: CustomRoundedButton(
      screenHeight: height,
      screenWidth: width,
      buttonHeight: 0.02,
      buttonWidth: 0.2,
      text: "Envoyer",
      icon: Icons.send,
      fontColor: FontColor.white,
      fontWeight: FontWeight.bold,
      backgroundColor: blue,
      borderColor: blue,
      onPressed: () => print("submitted"),
    ));
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(
          context: this.context,
          heightScreen: _screenHeight,
          widthScreen: _screenWidth),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullDown: false,
        enablePullUp: false,
        header: WaterDropMaterialHeader(),
        child: Container(
          child: ListView(
            children: <Widget>[
              buildTopContent(_screenHeight, _screenWidth),
              buildImageMap(_screenHeight, _screenWidth),
              Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05)),
              buildSubmitButton(_screenHeight, _screenWidth),
              Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05)),
            ],
          ),
        ),
      ),
    );
  }
}
