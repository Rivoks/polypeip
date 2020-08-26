import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomBottomBarAlt.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/custom_widgets/CustomTopbarAlt.dart';
import 'package:polypeip/pages/infoPages/InfoGoodiesPage.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageriePage extends StatefulWidget {
  @override
  _MessageriePageState createState() => _MessageriePageState();
}

class _MessageriePageState extends State<MessageriePage> {
  double _screenHeight;
  double _screenWidth;
  CarouselController buttonCarouselController = CarouselController();

  Color adminColor = Color(0xFF7f8fa6);

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map<String, String>> listMessages = [
    {
      "_id": "618ze9f4zfze496",
      "title": "Avis",
      "date": "04/05/2020",
      "author": "Robert",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec neque sapien. Proin suscipit commodo tellus, efficitur finibus nulla sollicitudin sagittis. Duis neque turpis, euismod vel porta non, varius pretium diam. Etiam non posuere justo. Vestibulum nec enim non tortor finibus pulvinar a ac ex. Mauris tempor, risus non accumsan egestas, felis erat lacinia neque, sed ornare mi ligula a erat. Praesent et augue consequat felis feugiat tincidunt. Nam libero urna, faucibus nec justo quis, convallis condimentum orci. Morbi nulla justo, venenatis et augue vel, ornare dapibus sapien. Nulla sed sodales felis. Etiam dictum sapien id lacus sagittis consequat. "
    },
    {
      "_id": "aze4a984da",
      "title": "Avis",
      "date": "15/05/2020",
      "author": "Léa",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec neque sapien. Proin suscipit commodo tellus, efficitur finibus nulla sollicitudin sagittis. Duis neque turpis, euismod vel porta non, varius pretium diam. Etiam non posuere justo. Vestibulum nec enim non tortor finibus pulvinar a ac ex. Mauris tempor, risus non accumsan egestas, felis erat lacinia neque, sed ornare mi ligula a erat. Praesent et augue consequat felis feugiat tincidunt. Nam libero urna, faucibus nec justo quis, convallis condimentum orci. Morbi nulla justo, venenatis et augue vel, ornare dapibus sapien. Nulla sed sodales felis. Etiam dictum sapien id lacus sagittis consequat. "
    },
  ];

  String listChoice = "new";

  final double topBarHeightPercent = 0.06;

  Widget buildTopContent() {
    return Container(
      width: _screenWidth,
      color: adminColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.02),
        child: Column(
          children: <Widget>[
            Icon(
              FontAwesome.edit,
              size: _screenHeight * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: _screenHeight * 0.01)),
            CustomText(
              text: "Messagerie",
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

  CarouselSlider buildSlider(height, width) {
    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        autoPlay: false,
        scrollPhysics: ClampingScrollPhysics(),
        onPageChanged: (page, changeReason) {
          setState(() {
            if (page == 0)
              listChoice = "new";
            else
              listChoice = "old";
          });
        },
      ),
      items: [
        ListView.builder(
            itemCount: listMessages.length,
            itemBuilder: (context, index) {
              return buildlistMessages(
                  listMessages[index]['id'],
                  listMessages[index]['title'],
                  listMessages[index]['date'],
                  listMessages[index]['author']);
            }),
        ListView.builder(
            itemCount: listMessages.length,
            itemBuilder: (context, index) {
              return buildlistMessages(
                  listMessages[index]['id'],
                  listMessages[index]['title'],
                  listMessages[index]['date'],
                  listMessages[index]['author']);
            }),
      ],
    );
  }

  Widget constructTopBar() {
    double topBarHeight = _screenHeight * topBarHeightPercent;

    return CustomTopbarAlt(
      context: context,
      widthScreen: _screenWidth,
      heightScreen: _screenHeight,
      appBarHeight: topBarHeightPercent,
      topBarChild: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              if (listChoice != "new") {
                buttonCarouselController.previousPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
                setState(() {
                  listChoice = "new";
                });
              }
            },
            child: new Container(
              alignment: Alignment.center,
              color: Colors.white,
              width: _screenWidth / 2,
              padding: EdgeInsets.only(left: _screenWidth / 8),
              height: topBarHeight,
              child: CustomText(
                text: "Messages reçus",
                fontColor:
                    (listChoice == 'old') ? FontColor.grey : FontColor.blue,
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              if (listChoice != "old") {
                buttonCarouselController.nextPage(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear,
                );
                setState(() {
                  listChoice = "old";
                });
              }
            },
            child: new Container(
              color: Colors.white,
              width: _screenWidth / 2,
              height: topBarHeight,
              padding: EdgeInsets.only(right: _screenWidth / 8),
              alignment: Alignment.center,
              child: CustomText(
                text: "Messages envoyés",
                fontColor:
                    (listChoice == 'new') ? FontColor.grey : FontColor.blue,
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildlistMessages(_id, title, date, author) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(color: Colors.grey[350], width: 0.5),
            )),
        width: _screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 0.05 * _screenWidth,
          vertical: 0.025 * _screenHeight,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              FontAwesome.mail_alt,
              color: CustomText.textColor(FontColor.blue),
              size: _screenHeight * 0.05,
            ),
            Padding(padding: EdgeInsets.only(right: _screenWidth * 0.05)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(
                  text: title,
                  fontColor: FontColor.blue,
                  fontSize: FontSize.md,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: author,
                  fontColor: FontColor.black,
                  fontSize: FontSize.sm,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: date,
                  fontColor: FontColor.darkGrey,
                  fontSize: FontSize.xs,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ],
        ),
      ),
      onTap: () {
        if (listChoice == 'new') {
          return Navigator.pushNamed(context, "/admin/messageRecevied",
              arguments: {"messageId": _id});
        } else {
          return Navigator.pushNamed(context, "/admin/message",
              arguments: {"messageId": _id});
        }
      },
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
        controller: RefreshController(initialRefresh: false),
        enablePullUp: true,
        header: WaterDropMaterialHeader(),
        onRefresh: () async {
          await Future.delayed(Duration(milliseconds: 1000));
          _refreshController.refreshCompleted();
        },
        onLoading: () async {
          print("loading");
        },
        child: ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: listMessages.length,
          itemBuilder: (context, index) {
            return Column(
              children: <Widget>[
                (index == 0) ? buildTopContent() : Container(),
                (index == 0) ? constructTopBar() : Container(),
                buildSlider(_screenHeight, _screenWidth)
              ],
            );
          },
        ),
      ),
      floatingActionButton: SpeedDial(
        marginRight: _screenWidth * 0.05,
        marginBottom: _screenHeight * 0.03,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: _screenHeight * 0.035),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.white,
        overlayOpacity: 0.6,
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: adminColor,
        foregroundColor: Colors.white,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.message),
            backgroundColor: blue,
            label: 'Envoyer un message',
            labelStyle: TextStyle(
                fontSize: _screenHeight * 0.02, fontWeight: FontWeight.bold),
            onTap: () {
              return Navigator.pushNamed(
                context,
                "/admin/answerMessage",
                arguments: {"messageId": "id"},
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBarAlt(
        context: context,
        heightScreen: _screenHeight,
        widthScreen: _screenWidth,
      ),
    );
  }
}
