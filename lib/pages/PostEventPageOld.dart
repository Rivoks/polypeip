import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polypeip/custom_widgets/CustomRate.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../custom_widgets/CustomBackAppBar.dart';

class PostEventPageOld extends StatefulWidget {
  PostEventPageOld({
    @required this.eventId,
  });

  final String eventId;

  @override
  _PostEventPageOldState createState() => _PostEventPageOldState();
}

class _PostEventPageOldState extends State<PostEventPageOld> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Event event;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  int rate = 0;

  @override
  void initState() {
    super.initState();

    getEvent(widget.eventId, false, context: context).then((value) {
      setState(() => event = value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    Color blue = CustomText.textColor(FontColor.blue);

    List<Map<String, dynamic>> comment = [
      {
        "_id": "1az96e4aze9",
        "pseudo": "SuperLapin75",
        "comment": "Super event à refaire au plus vite !!!!",
        "img": "assets/img/logo_alt.png",
        "rate": 3,
      },
      {
        "_id": "1az96e4aze9",
        "pseudo": "SuperLapin75",
        "comment":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec neque sapien. Proin suscipit commodo tellus, efficitur finibus nulla sollicitudin sagittis. Duis neque turpis, euismod vel porta non, varius pretium diam. Etiam non posuere justo. Vestibulum nec enim non tortor finibus pulvinar a ac ex. Mauris tempor, risus non accumsan egestas, felis erat lacinia neque, sed ornare mi ligula a erat. Praesent et augue consequat felis feugiat tincidunt. Nam libero urna, faucibus nec justo quis, convallis condimentum orci. Morbi nulla justo, venenatis et augue vel, ornare dapibus sapien. Nulla sed sodales felis. Etiam dictum sapien id lacus sagittis consequat. ",
        "img": "assets/img/logo_alt.png",
        "rate": 3,
      },
      {
        "_id": "1az96e4aze9",
        "pseudo": "SuperLapin75",
        "comment": "Super event à refaire au plus vite !!!!",
        "img": "assets/img/logo_alt.png",
        "rate": 3,
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
                                      color: Colors.grey[350]),
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
                                        vertical: _screenHeight * 0.04),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        width: _screenWidth * 0.7,
                                        height: 1,
                                        color: blue,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: CustomText(
                                      text: "Donnez votre avis !",
                                      fontColor: FontColor.blue,
                                      fontSize: FontSize.xl,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  CustomRate(
                                    rate: rate,
                                    setRate: (tmpRate) {
                                      rateEvent(event.id, tmpRate,
                                              context: context)
                                          .then((value) => value == 200
                                              ? setState(() => rate = tmpRate)
                                              : null);
                                    },
                                    heightScreen: _screenHeight,
                                    widthScreen: _screenWidth,
                                    size: 0.05,
                                    color: blue,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        bottom: _screenHeight * 0.03),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: blue,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                          _screenWidth * 0.08),
                                    ),
                                    width: _screenWidth,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Expanded(
                                          child: TextField(
                                              textInputAction:
                                                  TextInputAction.done,
                                              minLines: 1,
                                              maxLines: 4,
                                              decoration: InputDecoration(
                                                border: InputBorder.none,
                                                hintText:
                                                    "Ecrivez votre message",
                                                hintStyle:
                                                    TextStyle(color: blue),
                                                contentPadding: EdgeInsets.only(
                                                    left: _screenWidth * 0.05),
                                              )),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              right: _screenWidth * 0.03),
                                          child: GestureDetector(
                                            child: Icon(
                                              Icons.send,
                                              color: blue,
                                            ),
                                            onTap: () => print("tap"),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ListView.builder(
                            itemCount: comment.length,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: _screenHeight * 0.04,
                                      horizontal: _screenWidth * 0.05,
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: (index == 0)
                                            ? Border(
                                                top: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 1),
                                              )
                                            : Border(bottom: BorderSide.none)),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.all(
                                                  _screenHeight * 0.013),
                                              margin: EdgeInsets.symmetric(
                                                horizontal: _screenWidth * 0.04,
                                              ),
                                              height: 0.08 * _screenHeight,
                                              width: 0.08 * _screenHeight,
                                              decoration: BoxDecoration(
                                                  color: CustomText.textColor(
                                                      FontColor.blue),
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              100))),
                                              child: Image.asset(
                                                  comment[index]['img']),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                      top: _screenHeight * 0.01,
                                                    ),
                                                  ),
                                                  CustomText(
                                                    text: comment[index]
                                                        ['pseudo'],
                                                    fontColor: FontColor.black,
                                                    fontSize: FontSize.md,
                                                    fontWeight: FontWeight.w500,
                                                    maxLines: 1,
                                                    alignment: TextAlign.start,
                                                    overflowStyle:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Container(
                                                    child: CustomRate(
                                                      heightScreen:
                                                          _screenHeight,
                                                      widthScreen: _screenWidth,
                                                      size: 0.02,
                                                      color: blue,
                                                      rate: comment[index]
                                                          ['rate'] as int,
                                                      setRate: null,
                                                      paddingVertial: 0.01,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                    ),
                                                  ),
                                                  Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom:
                                                              _screenHeight *
                                                                  0.008)),
                                                  CustomText(
                                                    text: comment[index]
                                                        ['comment'],
                                                    fontColor:
                                                        FontColor.darkGrey,
                                                    fontSize: FontSize.sm,
                                                    maxLines: pow(10, 10),
                                                    alignment: TextAlign.start,
                                                    overflowStyle:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
          ),
        ),
      ),
    );
  }
}
