import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostMessagerieReceviedPage extends StatefulWidget {
  PostMessagerieReceviedPage({@required this.messageId});

  final String messageId;

  @override
  _PostMessagerieReceviedPageState createState() =>
      _PostMessagerieReceviedPageState();
}

class _PostMessagerieReceviedPageState
    extends State<PostMessagerieReceviedPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    List<Map<String, String>> message = [
      {
        "_id": "16ea84d9az4az8",
        "title": "Titre du message",
        "date": "03/05/2020",
        "message":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec lacus eros. Donec turpis eros, convallis in rhoncus id, facilisis at magna.\n\n Nunc mauris tellus, aliquet vel libero a, pharetra blandit justo. Aenean sit amet dignissim mi, et venenatis lorem. Morbi interdum purus tellus, eu lacinia nibh consequat fermentum. Donec quis aliquet mauris.\n\n Donec a tortor eget turpis tempor aliquet in at tellus. In hac habitasse platea dictumst. Mauris condimentum sapien id nunc tincidunt, at sollicitudin nibh fermentum. Curabitur pretium bibendum diam, aliquam feugiat velit euismod vitae. Donec vestibulum eget nibh non aliquam.\n\n Donec vestibulum nisi sit amet libero volutpat, eu vehicula orci commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tellus nibh, iaculis sit amet hendrerit sed, viverra ac nulla. Donec fringilla sapien nisl, eu fringilla massa consequat vel.\n\n Pellentesque ac malesuada ligula, vel viverra purus. Integer sed odio purus. Duis non congue erat, mollis eleifend elit.\n Phasellus porttitor pharetra dui, nec varius sapien ultrices non. Sed fermentum laoreet est, sit amet bibendum sapien rhoncus sit amet. Vivamus nulla neque, faucibus id suscipit sit amet, pellentesque vitae nisl.\n\n Sed tempus, magna vestibulum tincidunt mattis, felis dui hendrerit felis, sed ornare sem arcu non mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque luctus molestie gravida.",
      },
    ];

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
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
          itemCount: message.length,
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
                      text: message[index]['title'],
                      fontColor: FontColor.black,
                      fontSize: FontSize.xl,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: _screenHeight * 0.01,
                        ),
                        child: CustomText(
                          text: 'Reçu le ' + message[index]['date'],
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
                        text: message[index]['message'],
                        fontColor: FontColor.black,
                        fontSize: FontSize.md,
                        fontWeight: FontWeight.w300,
                        maxLines: pow(10, 10),
                      ),
                    ),
                  ],
                ));
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
            child: Icon(Icons.question_answer),
            backgroundColor: Colors.green,
            label: 'Répondre',
            labelStyle: TextStyle(
                fontSize: _screenHeight * 0.02, fontWeight: FontWeight.bold),
            onTap: () {
              return Navigator.pushNamed(
                context,
                "/admin/answerMessage",
                arguments: {"messageId": message[0]['_id']},
              );
            },
          ),
        ],
      ),
    );
  }
}
