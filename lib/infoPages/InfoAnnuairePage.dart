import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoAnnuairePage extends StatefulWidget {
  @override
  _InfoAnnuairePageState createState() => _InfoAnnuairePageState();
}

class _InfoAnnuairePageState extends State<InfoAnnuairePage> {
  bool _isTapped = false;
  String _currentSettings = "";

  List<Map<String, String>> staffMember = [
    {
      "_id": "az64ea4e6",
      "name": "Yanick",
      "email": "yanick@gmail.com",
      "phone": "0604659846",
    },
    {
      "_id": "az64ea4e6",
      "name": "Henri",
      "email": "henri@gmail.com",
      "phone": "0649873249",
    },
  ];

  List<Map<String, String>> listMedias = [
    {
      "_id": "qdq6s4d5",
      "media": "Facebook",
      "page": "Polypeip",
      "url": "https://www.facebook.com/",
    },
    {
      "_id": "qdq6s4d5",
      "media": "Discord",
      "page": "ServerPeip",
      "url": "https://discord.com/",
    },
  ];

  List<Map<String, String>> listLinks = [
    {
      "_id": "4z6r46a",
      "linkName": "Fichier Excel",
      "url": "https://www.facebook.com/",
    },
  ];

  Widget buildParamsContainer(height, width, textParams, last) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.grey[350], width: 0.5),
                  bottom: last
                      ? BorderSide(color: Colors.grey[350], width: 0.5)
                      : BorderSide.none)),
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.075,
            vertical: height * 0.032,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 0.8 * width,
                child: CustomText(
                  text: textParams,
                  fontColor: FontColor.blue,
                  fontSize: FontSize.md,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: CustomText.textColor(FontColor.blue),
                  size: height * 0.025,
                ),
              )
            ],
          )),
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
          _currentSettings = textParams;
        });
      },
    );
  }

  Widget singleAreaSetting(
      height, width, textParams, last, containerWidth, subChild) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(color: Colors.grey[350], width: 0.5),
            )),
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.075,
          vertical: height * 0.032,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: containerWidth * width,
              child: CustomText(
                text: textParams,
                fontColor: FontColor.blue,
                fontSize: FontSize.md,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: subChild,
            )
          ],
        ));
  }

  Widget buildAnnuaire(height, width, page) {
    if (page == "Réseaux sociaux") {
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listMedias.length,
        itemBuilder: (context, index) {
          return singleAreaSetting(
            height,
            width,
            listMedias[index]['media'],
            false,
            0.45,
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                GestureDetector(
                  child: CustomText(
                    text: listMedias[index]['page'],
                    fontColor: FontColor.darkGrey,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                  ),
                  onTap: () {
                    launch(listMedias[index]['url']);
                  },
                ),
              ],
            ),
          );
        },
      );
    } else if (page == "Contact") {
      return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: staffMember.length,
          itemBuilder: (context, index) {
            return singleAreaSetting(
              height,
              width,
              staffMember[index]['name'],
              false,
              0.45,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: CustomText(
                      text: 'Tel :' + staffMember[index]['phone'],
                      fontColor: FontColor.darkGrey,
                      fontSize: FontSize.md,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      launch('tel:<' + staffMember[index]['phone'] + '>');
                    },
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(vertical: width * 0.01)),
                  GestureDetector(
                    child: CustomText(
                      text: staffMember[index]['email'],
                      fontColor: FontColor.darkGrey,
                      fontSize: FontSize.md,
                    ),
                    onTap: () {
                      launch('mailto:<' + staffMember[index]['email'] + '>');
                    },
                  )
                ],
              ),
            );
          });
    } else if (page == "Liens utiles") {
      return ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: listLinks.length,
        itemBuilder: (context, index) {
          return singleAreaSetting(
            height,
            width,
            listLinks[index]['linkName'],
            false,
            0.7,
            GestureDetector(
              child: Icon(
                FontAwesome.folder_open,
                size: height * 0.02,
                color: CustomText.textColor(FontColor.blue),
              ),
              onTap: () => {},
            ),
          );
        },
      );
    }
    return Container();
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
              FontAwesome.book,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "Annuaire",
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

  Widget buildTopBar(height, width, currentSettings) {
    return GestureDetector(
      child: Container(
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.04,
          vertical: height * 0.015,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.arrow_back_ios,
              size: height * 0.018,
              color: CustomText.textColor(FontColor.darkGrey),
            ),
            Padding(padding: EdgeInsets.only(right: width * 0.02)),
            CustomText(
              text: currentSettings,
              fontColor: FontColor.darkGrey,
              fontSize: FontSize.sm,
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
        });
      },
    );
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
        body: Container(
          child: _isTapped == false
              ? Column(
                  children: <Widget>[
                    buildTopContent(_screenHeight, _screenWidth),
                    buildParamsContainer(
                      _screenHeight,
                      _screenWidth,
                      "Contact",
                      false,
                    ),
                    buildParamsContainer(
                      _screenHeight,
                      _screenWidth,
                      "Réseaux sociaux",
                      false,
                    ),
                    buildParamsContainer(
                      _screenHeight,
                      _screenWidth,
                      "Liens utiles",
                      true,
                    ),
                    Padding(padding: EdgeInsets.only(top: _screenHeight * 0.05))
                  ],
                )
              : Column(
                  children: <Widget>[
                    buildTopContent(_screenHeight, _screenWidth),
                    buildTopBar(_screenHeight, _screenWidth, _currentSettings),
                    buildAnnuaire(_screenHeight, _screenWidth, _currentSettings)
                  ],
                ),
        ));
  }
}
