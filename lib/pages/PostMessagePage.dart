import 'dart:math';

import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Message.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../custom_widgets/CustomBackAppBar.dart';

// class PostMessagePage extends StatefulWidget {
//   PostMessagePage({@required this.message});

//   @override
//   _PostMessagePageState createState() => _PostMessagePageState();
// }

class PostMessagePage extends StatelessWidget {
  final Message message;
  PostMessagePage({@required this.message});

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
          key: _scaffoldKey,
          appBar: CustomBackAppBar(
              context: context,
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
                  itemCount: message != null ? 1 : 0,
                  itemBuilder: (context, index) {
                    return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: _screenWidth * 0.05,
                          vertical: _screenHeight * 0.05,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CustomText(
                              text: message.subject,
                              fontColor: FontColor.black,
                              fontSize: FontSize.xl,
                              fontWeight: FontWeight.bold,
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(
                                  vertical: _screenHeight * 0.01,
                                ),
                                child: CustomText(
                                  text: 'Reçu le ' +
                                      message.date.toIso8601String(),
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
                                text: message.content,
                                fontColor: FontColor.black,
                                fontSize: FontSize.md,
                                fontWeight: FontWeight.w300,
                                maxLines: pow(10, 10),
                              ),
                            ),
                          ],
                        ));
                  })),
        ),
      ),
    );
  }
}
