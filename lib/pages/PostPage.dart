import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Post.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../custom_widgets/CustomBackAppBar.dart';

class PostPage extends StatefulWidget {
  PostPage({@required this.post, this.setPost});

  final Post post;
  final Function setPost;

  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Post post;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    post = widget.post;
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _imageHeight = _screenHeight * 0.25;

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
              child: ListView.builder(
                  itemCount: 1,
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
                                  imageUrl: post.img,
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
                                        text: post.totalLikes.toString(),
                                        fontColor: post.likeStatus == 1
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
                                          color: post.likeStatus == 1
                                              ? CustomText.textColor(
                                                  FontColor.yellow)
                                              : Colors.white),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: _screenWidth * 0.03)),
                                      CustomText(
                                        text: post.nbTotalDislikes == 0
                                            ? "0"
                                            : post.nbTotalDislikes.toString(),
                                        fontColor: post.likeStatus == -1
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
                                          color: post.likeStatus == -1
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
                              text: post.name,
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
                                text: post.date.toIso8601String(),
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
                                text: post.content,
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
                    fontSize: _screenHeight * 0.02,
                    fontWeight: FontWeight.bold),
                onTap: () => reactPost(
                  post.id,
                  "dislike",
                  context: context,
                ).then(
                  (_) {
                    setState(() {
                      post.likeStatus = -1;
                    });
                    getPost(
                      post.id,
                      context: context,
                    ).then((value) {
                      widget.setPost(value);
                      setState(() => post = value);
                    });
                  },
                ),
              ),
              SpeedDialChild(
                child: Icon(Icons.thumb_up),
                backgroundColor: Colors.green,
                label: 'J\'aime',
                labelStyle: TextStyle(
                    fontSize: _screenHeight * 0.02,
                    fontWeight: FontWeight.bold),
                onTap: () => reactPost(
                  post.id,
                  "like",
                  context: context,
                ).then(
                  (_) {
                    setState(() {
                      post.likeStatus = 1;
                    });
                    getPost(
                      post.id,
                      context: context,
                    ).then((value) {
                      widget.setPost(value);
                      setState(() => post = value);
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
