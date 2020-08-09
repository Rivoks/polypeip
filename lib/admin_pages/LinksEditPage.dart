import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class LinksEditPage extends StatefulWidget {
  LinksEditPage({@required this.linksId});

  final String linksId;

  @override
  _LinksEditPageState createState() => _LinksEditPageState();
}

class _LinksEditPageState extends State<LinksEditPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  double _screenHeight;
  double _screenWidth;

  double spaceInput = 0.1;

  Color blue = CustomText.textColor(FontColor.blue);

  Color adminColor = Color(0xFF7f8fa6);

  Widget buildTopContent() {
    return Container(
      height: _screenHeight * 0.154,
      width: _screenWidth,
      color: adminColor,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.01),
          ),
          Icon(
            FontAwesome.edit,
            size: _screenHeight * 0.07,
            color: CustomText.textColor(FontColor.white),
          ),
          Padding(padding: EdgeInsets.only(top: _screenHeight * 0.01)),
          CustomText(
            text: "Modifier un lien utile",
            fontColor: FontColor.white,
            fontSize: FontSize.lg,
            uppercase: true,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _screenWidth * 0.08, vertical: _screenHeight * 0.04),
      child: CustomText(
        text: "Remplissez les champs pour modifier un lien",
        fontColor: FontColor.darkGrey,
        fontSize: FontSize.md,
        fontWeight: FontWeight.w500,
        alignment: TextAlign.center,
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.15),
      child: CustomRoundedButton(
        screenHeight: _screenHeight,
        screenWidth: _screenWidth,
        buttonHeight: 0.02,
        buttonWidth: 0,
        text: "Modifier",
        fontColor: FontColor.white,
        fontWeight: FontWeight.bold,
        backgroundColor: blue,
        borderColor: blue,
        onPressed: () => print('submit'),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(
              hintText: "Titre",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.02)),
          TextField(
            decoration: InputDecoration(
              hintText: "URL du lien",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.1)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

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
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    buildTopContent(),
                    buildTitle(),
                    Padding(
                        padding: EdgeInsets.only(bottom: _screenHeight * 0.02)),
                    buildForm(),
                    buildSubmitButton(),
                    Padding(
                        padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
