import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/custom_widgets/CustomTextArea.dart';
import 'package:polypeip/infoPages/InfoGoodiesPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfoIdeaPage extends StatefulWidget {
  @override
  _InfoIdeaPageState createState() => _InfoIdeaPageState();
}

class _InfoIdeaPageState extends State<InfoIdeaPage> {
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
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.05),
          ),
          Icon(
            FontAwesome.assistive_listening_systems,
            color: blue,
            size: _screenHeight * 0.08,
          ),
          Container(
            padding: EdgeInsets.only(top: _screenHeight * 0.02),
            child: CustomText(
              alignment: TextAlign.center,
              text: "Polypeip est à votre écoute !",
              fontColor: FontColor.blue,
              fontSize: FontSize.xl,
              fontWeight: FontWeight.bold,
              maxLines: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.01),
          ),
          Container(
            child: CustomText(
              alignment: TextAlign.center,
              text:
                  "Une idée pour le prochain event ?\nUne remarque pour améliorer l'association ?\nUne question plus ou moins gênante ?\nEcris-nous en dessous et on vous recontacte au plus vite !",
              fontColor: FontColor.darkGrey,
              fontSize: FontSize.sm,
              fontWeight: FontWeight.w400,
              maxLines: 10,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.04),
          ),
          CustomTextArea(
            heightScreen: _screenHeight,
            widthScreen: _screenWidth,
            inputColor: Colors.grey[800],
            borderColor: blue,
            placeHolder: "Titre de votre idée",
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
          body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: false,
            enablePullUp: false,
            header: WaterDropMaterialHeader(),
            child: Container(
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: <Widget>[
                // buildTopContent(_screenHeight, _screenWidth),
                // buildImageMap(_screenHeight, _screenWidth),
                // Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05)),
                //   ],
                // ),
                child: ListView(
              children: <Widget>[
                buildTopContent(_screenHeight, _screenWidth),
                buildImageMap(_screenHeight, _screenWidth),
                Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05)),
                buildSubmitButton(_screenHeight, _screenWidth),
                Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05)),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
