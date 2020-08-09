import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PostPage extends StatefulWidget {
  PostPage({@required this.postId});

  final String postId;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isLiked = false;
  bool _isDisliked = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _imageHeight = _screenHeight * 0.25;

    List<Map<String, String>> posts = [
      {
        "_id": "16ea84d9az4az8",
        "title": "Quais St Bernard - 18h00",
        "date": "01/05/2020",
        "description":
            " Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent nec lacus eros. Donec turpis eros, convallis in rhoncus id, facilisis at magna.\n\n Nunc mauris tellus, aliquet vel libero a, pharetra blandit justo. Aenean sit amet dignissim mi, et venenatis lorem. Morbi interdum purus tellus, eu lacinia nibh consequat fermentum. Donec quis aliquet mauris.\n\n Donec a tortor eget turpis tempor aliquet in at tellus. In hac habitasse platea dictumst. Mauris condimentum sapien id nunc tincidunt, at sollicitudin nibh fermentum. Curabitur pretium bibendum diam, aliquam feugiat velit euismod vitae. Donec vestibulum eget nibh non aliquam.\n\n Donec vestibulum nisi sit amet libero volutpat, eu vehicula orci commodo. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas tellus nibh, iaculis sit amet hendrerit sed, viverra ac nulla. Donec fringilla sapien nisl, eu fringilla massa consequat vel.\n\n Pellentesque ac malesuada ligula, vel viverra purus. Integer sed odio purus. Duis non congue erat, mollis eleifend elit.\n Phasellus porttitor pharetra dui, nec varius sapien ultrices non. Sed fermentum laoreet est, sit amet bibendum sapien rhoncus sit amet. Vivamus nulla neque, faucibus id suscipit sit amet, pellentesque vitae nisl.\n\n Sed tempus, magna vestibulum tincidunt mattis, felis dui hendrerit felis, sed ornare sem arcu non mi. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Pellentesque luctus molestie gravida.",
        "img":
            "https://static.lexpress.fr/medias_11577/w_2000,h_1120,c_fill,g_center/v1502354725/paris-vu-du-ciel-des-images-epoustouflantes-filmees-par-un-drone_5927848.jpg",
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
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Container(
                  width: _screenWidth,
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: <Widget>[
                            CachedNetworkImage(
                              imageUrl: posts[index]["img"],
                              height: _imageHeight,
                              width: _screenWidth,
                              fit: BoxFit.fill,
                              placeholder: (context, url) {
                                return Container(
                                    height: _imageHeight,
                                    width: _screenWidth,
                                    color: Colors.grey[400]);
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(100.0)),
                                color: Color(0xd900adef),
                              ),
                              margin: EdgeInsets.only(
                                  bottom: _screenHeight * 0.013),
                              alignment: Alignment.center,
                              height: _imageHeight * 0.2,
                              width: _screenWidth * 0.4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  CustomText(
                                    text: "76",
                                    fontColor: _isLiked
                                        ? FontColor.yellow
                                        : FontColor.white,
                                    fontSize: FontSize.md,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: _screenWidth * 0.005)),
                                  Icon(Icons.thumb_up,
                                      size: _screenHeight * 0.025,
                                      color: _isLiked
                                          ? CustomText.textColor(
                                              FontColor.yellow)
                                          : Colors.white),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: _screenWidth * 0.03)),
                                  CustomText(
                                    text: "18",
                                    fontColor: _isDisliked
                                        ? FontColor.yellow
                                        : FontColor.white,
                                    fontSize: FontSize.md,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          right: _screenWidth * 0.005)),
                                  Icon(Icons.thumb_down,
                                      size: _screenHeight * 0.025,
                                      color: _isDisliked
                                          ? CustomText.textColor(
                                              FontColor.yellow)
                                          : Colors.white)
                                ],
                              ),
                            ),
                          ]),
                      Padding(
                        padding: EdgeInsets.only(
                            top: _screenHeight * 0.03,
                            right: _screenWidth * 0.08,
                            left: _screenWidth * 0.08),
                        child: CustomText(
                          text: posts[index]["title"],
                          fontColor: FontColor.black,
                          fontSize: FontSize.lg,
                          fontWeight: FontWeight.bold,
                          uppercase: true,
                          alignment: TextAlign.start,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(
                              top: _screenHeight * 0.010,
                              bottom: _screenHeight * 0.018,
                              right: _screenWidth * 0.08,
                              left: _screenWidth * 0.08),
                          child: CustomText(
                            text: posts[index]["date"],
                            fontColor: FontColor.darkGrey,
                            fontSize: FontSize.sm,
                            fontWeight: FontWeight.normal,
                            uppercase: true,
                            alignment: TextAlign.start,
                          )),
                      Container(
                          height: 1,
                          width: 0.7 * _screenWidth,
                          color: Colors.grey[300]),
                      Padding(
                          padding: EdgeInsets.only(
                              top: _screenHeight * 0.02,
                              bottom: _screenHeight * 0.015,
                              right: _screenWidth * 0.08,
                              left: _screenWidth * 0.08),
                          child: CustomText(
                            text: posts[index]["description"],
                            fontColor: FontColor.black,
                            fontSize: FontSize.md,
                            fontWeight: FontWeight.normal,
                            uppercase: false,
                            alignment: TextAlign.start,
                            maxLines: pow(10, 10),
                          ))
                    ],
                  ),
                );
              })),
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
            backgroundColor: Colors.red,
            label: 'Je n\'aime pas',
            labelStyle: TextStyle(
                fontSize: _screenHeight * 0.02, fontWeight: FontWeight.bold),
            onTap: () => {
              setState(() {
                if (_isDisliked) {
                  _isDisliked = false;
                } else {
                  _isDisliked = true;
                  _isLiked = false;
                }
              })
            },
          ),
          SpeedDialChild(
              child: Icon(Icons.thumb_up),
              backgroundColor: Colors.green,
              label: 'J\'aime',
              labelStyle: TextStyle(
                  fontSize: _screenHeight * 0.02, fontWeight: FontWeight.bold),
              onTap: () => {
                    setState(() {
                      if (_isLiked) {
                        _isLiked = false;
                      } else {
                        _isDisliked = false;
                        _isLiked = true;
                      }
                    })
                  }),
        ],
      ),
    );
  }
}
