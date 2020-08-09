import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListReseauxPage extends StatefulWidget {
  @override
  _ListReseauxPageState createState() => _ListReseauxPageState();
}

class _ListReseauxPageState extends State<ListReseauxPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map<String, String>> socialMedias = [
    {
      "id": "64ad4z9a4d",
      "name": "Discord",
      "mediaName": "PolyServ",
      "link": "https://www.discordapp.com",
    },
    {
      "id": "64ad4z9a4d",
      "name": "Snapchat",
      "mediaName": "polypeip.sc2020",
      "link": "https://www.snapchat.com",
    },
  ];

  Color adminColor = Color(0xFF7f8fa6);

  Widget buildEditForm(height, width, index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        height: height * 0.13,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey[400], width: 0.3),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
                color: Colors.grey[400],
                blurRadius: 5, // has the effect of softening the shadow
                spreadRadius: -5, // has the effect of extending the shadow
                offset: Offset(
                  0, // horizontal, move right 10
                  8, // vertical, move down 10
                ))
          ],
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: width * 0.6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    text: socialMedias[index]['name'],
                    fontColor: FontColor.black,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                  ),
                  Padding(padding: EdgeInsets.only(bottom: height * 0.01)),
                  CustomText(
                    text: socialMedias[index]['mediaName'],
                    fontColor: FontColor.black,
                    fontSize: FontSize.sm,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: socialMedias[index]['link'],
                    fontColor: FontColor.darkGrey,
                    fontSize: FontSize.sm,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.edit, color: Colors.grey[800]),
                    onTap: () => {
                      Navigator.pushNamed(context, "/edit/editReseaux",
                          arguments: {"reseauxId": socialMedias[index]['_id']})
                    },
                  ),
                  Padding(padding: EdgeInsets.only(right: width * 0.05)),
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.grey[800]),
                    onTap: () => print("delete"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddButton(height, width) {
    return Container(
      child: CustomRoundedButton(
        screenHeight: height,
        screenWidth: width,
        buttonHeight: 0.03,
        buttonWidth: 0,
        text: "Ajouter un réseau social",
        fontColor: FontColor.blue,
        fontSize: FontSize.md,
        fontWeight: FontWeight.bold,
        backgroundColor: null,
        borderColor: CustomText.textColor(FontColor.blue),
        onPressed: () => {Navigator.pushNamed(context, "/edit/addReseaux")},
      ),
    );
  }

  Widget buildTopContent(height, width) {
    return Container(
      width: width,
      color: adminColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        child: Column(
          children: <Widget>[
            Icon(
              FontAwesome.edit,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "gérer les réseaux sociaux",
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(
          context: this.context,
          heightScreen: _screenHeight,
          widthScreen: _screenWidth),
      body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(),
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: socialMedias.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (index == 0)
                      ? buildTopContent(_screenHeight, _screenWidth)
                      : Container(),
                  (index == 0)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: _screenHeight * 0.03,
                            horizontal: _screenWidth * 0.05,
                          ),
                          child: buildAddButton(_screenHeight, _screenWidth),
                        )
                      : Container(),
                  Padding(padding: EdgeInsets.only(top: _screenHeight * 0.03)),
                  buildEditForm(_screenHeight, _screenWidth, index),
                  (index == socialMedias.length - 1)
                      ? Padding(
                          padding: EdgeInsets.only(top: _screenHeight * 0.05))
                      : Container(),
                ],
              );
            },
          )),
    );
  }
}