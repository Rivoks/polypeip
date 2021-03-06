import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../custom_widgets/CustomBackAppBar.dart';

class PostEventPage extends StatefulWidget {
  PostEventPage({@required this.eventId});

  final String eventId;

  @override
  _PostEventPageState createState() => _PostEventPageState();
}

class _PostEventPageState extends State<PostEventPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Event event;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int rate = 0;

  @override
  void initState() {
    super.initState();

    getEvent(widget.eventId, true, context: context).then((value) {
      setState(() => event = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    List<Map<String, String>> student = [
      {
        "_id": "6aze54azea894",
        "name": "Yazid",
        "surname": "Bouhria",
      },
      {
        "_id": "6aze54azea894",
        "name": "Oussama",
        "surname": "ABBAS",
      },
      {
        "_id": "6aze54azea894",
        "name": "Jean-Jacques",
        "surname": "Rousseau",
      },
    ];

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
          key: _scaffoldKey,
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
            child: event == null
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: event != null ? 1 : 0,
                    itemBuilder: (context, index) {
                      return Column(
                        children: <Widget>[
                          Container(
                            color: Colors.white,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: _screenWidth * 0.05,
                                vertical: _screenHeight * 0.05,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  CustomText(
                                    text: event.name,
                                    fontColor: FontColor.black,
                                    fontSize: FontSize.xl,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                        vertical: _screenHeight * 0.01,
                                      ),
                                      child: CustomText(
                                        text: event.date.toIso8601String(),
                                        fontColor: FontColor.darkGrey,
                                        fontSize: FontSize.sm,
                                      )),
                                  Container(
                                    height: 1,
                                    width: _screenWidth,
                                    color: Colors.grey[350],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      vertical: _screenWidth * 0.07,
                                    ),
                                    child: CustomText(
                                      text: event.description,
                                      fontColor: FontColor.black,
                                      fontSize: FontSize.md,
                                      fontWeight: FontWeight.w400,
                                      maxLines: pow(10, 10),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: _screenHeight * 0.07),
                                    child: Container(
                                      height: 1,
                                      width: _screenWidth,
                                      color:
                                          CustomText.textColor(FontColor.blue),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    width: _screenWidth,
                                    margin: EdgeInsets.only(
                                        bottom: _screenHeight * 0.03),
                                    padding: EdgeInsets.symmetric(
                                      vertical: _screenHeight * 0.01,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:
                                          CustomText.textColor(FontColor.blue),
                                    ),
                                    child: CustomText(
                                      text: "Liste des participants",
                                      fontColor: FontColor.white,
                                      fontSize: FontSize.lg,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: ClampingScrollPhysics(),
                                    itemCount: student.length,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(
                                              bottom: _screenHeight * 0.03,
                                            ),
                                          ),
                                          Row(
                                            children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    right:
                                                        _screenHeight * 0.015),
                                                child: Icon(
                                                  Icons.check,
                                                  color: Colors.black,
                                                  size: _screenHeight * 0.03,
                                                ),
                                              ),
                                              CustomText(
                                                text: student[index]['surname'],
                                                fontColor: FontColor.black,
                                                fontSize: FontSize.md,
                                                fontWeight: FontWeight.bold,
                                                uppercase: true,
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  right: _screenHeight * 0.006,
                                                ),
                                              ),
                                              CustomText(
                                                text: student[index]['name'],
                                                fontColor: FontColor.black,
                                                fontSize: FontSize.md,
                                                fontWeight: FontWeight.bold,
                                                uppercase: false,
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
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
            backgroundColor: CustomText.textColor(FontColor.blue),
            foregroundColor: Colors.white,
            elevation: 8.0,
            shape: CircleBorder(),
            children: [
              SpeedDialChild(
                child: Icon(Icons.thumb_down),
                backgroundColor: CustomText.textColor(FontColor.grey),
                label: 'Je ne participe pas',
                labelStyle: TextStyle(
                    fontSize: _screenHeight * 0.02,
                    fontWeight: FontWeight.bold),
                onTap: () => null,
              ),
              SpeedDialChild(
                child: Icon(Icons.thumb_up),
                backgroundColor: CustomText.textColor(FontColor.yellow),
                label: 'Je participe',
                labelStyle: TextStyle(
                    fontSize: _screenHeight * 0.02,
                    fontWeight: FontWeight.bold),
                onTap: () => null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
