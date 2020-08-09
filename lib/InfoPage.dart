import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomAppBar.dart';
import 'package:polypeip/custom_widgets/CustomBottomBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfoPage extends StatefulWidget {
  @override
  _InfoPageState createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  double _screenHeight;
  double _screenWidth;

  Color blue = CustomText.textColor(FontColor.blue);

  Widget buildTopContent() {
    return Container(
        width: _screenWidth,
        color: CustomText.textColor(FontColor.blue),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.02),
            child: Column(
              children: <Widget>[
                Icon(
                  FontAwesome.info_circled,
                  size: _screenHeight * 0.07,
                  color: CustomText.textColor(FontColor.white),
                ),
                Padding(padding: EdgeInsets.only(top: _screenHeight * 0.01)),
                CustomText(
                  text: "Les informations utiles",
                  fontColor: FontColor.white,
                  fontSize: FontSize.lg,
                  uppercase: true,
                  fontWeight: FontWeight.bold,
                )
              ],
            )));
  }

  Widget buildBoxContent(text, icon, push) {
    return GestureDetector(
      child: Container(
        height: _screenHeight * 0.15,
        width: _screenHeight * 0.17,
        decoration: BoxDecoration(
          color: blue,
          borderRadius: BorderRadius.circular(_screenHeight * 0.015),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              color: Colors.white,
              size: _screenHeight * 0.06,
            ),
            Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.015)),
            CustomText(
              text: text,
              fontColor: FontColor.white,
              fontSize: (push == "/infoDance") ? FontSize.sm : FontSize.md,
              fontWeight: FontWeight.w700,
              uppercase: false,
            ),
          ],
        ),
      ),
      onTap: () {
        return Navigator.pushNamed(context, push);
      },
    );
  }

  Widget buildInfoPage(text1, icon1, push1, text2, icon2, push2) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.02)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            buildBoxContent(text1, icon1, push1),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: _screenWidth * 0.05,
              ),
            ),
            buildBoxContent(text2, icon2, push2),
          ],
        )
      ],
    );
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
          context: this.context,
          heightScreen: _screenHeight,
          widthScreen: _screenWidth),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: false,
        enablePullDown: false,
        header: WaterDropMaterialHeader(),
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          _refreshController.refreshCompleted();
        },
        child: Container(
          child: Column(
            children: <Widget>[
              buildTopContent(),
              buildInfoPage(
                "Annuaire",
                FontAwesome.book,
                "/infoAnnuaire",
                "Plan",
                FontAwesome.map_1,
                "/infoPlan",
              ),
              buildInfoPage(
                "EDT",
                FontAwesome.calendar_minus_o,
                "/infoEdt",
                "Vos Idées",
                FontAwesome.lightbulb,
                "/infoIdea",
              ),
              buildInfoPage(
                "Goodies",
                FontAwesome.shopping_bag,
                "/infoGoodies",
                '"Dance U Moove"',
                FontAwesome.music,
                "/infoDance",
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomBar(
          context: this.context,
          heightScreen: _screenHeight,
          widthScreen: _screenWidth),
    );
  }
}
