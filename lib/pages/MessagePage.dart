import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:polypeip/custom_widgets/CustomAppBar.dart';
import 'package:polypeip/custom_widgets/CustomBottomBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Message.dart';
import 'package:polypeip/pages/PostMessagePage.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  double _screenHeight;
  double _screenWidth;
  List<Message> messages;

  @override
  void initState() {
    super.initState();

    getMessages(context: context).then((res) {
      setState(() => messages = res);
    });
  }

  Widget buildListMsg(Message msg) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border:
                  Border(top: BorderSide(color: Colors.grey[350], width: 0.5))),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(_screenHeight * 0.013),
                    margin: EdgeInsets.symmetric(
                        horizontal: _screenWidth * 0.04,
                        vertical: _screenHeight * 0.02),
                    height: 0.08 * _screenHeight,
                    width: 0.08 * _screenHeight,
                    decoration: BoxDecoration(
                        color: CustomText.textColor(FontColor.blue),
                        borderRadius: BorderRadius.all(Radius.circular(100))),
                    child: Image.asset("assets/img/logo_alt.png"),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      CustomText(
                        text: msg.subject,
                        fontColor: FontColor.black,
                        fontSize: FontSize.md,
                        fontWeight: FontWeight.w500,
                        maxLines: 1,
                        alignment: TextAlign.start,
                        overflowStyle: TextOverflow.ellipsis,
                      ),
                      CustomText(
                        text: msg.date.toIso8601String(),
                        fontColor: FontColor.darkGrey,
                        fontSize: FontSize.xs,
                        maxLines: 1,
                        alignment: TextAlign.start,
                        overflowStyle: TextOverflow.ellipsis,
                      ),
                    ],
                  )),
                ],
              ),
            ],
          )),
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: PostMessagePage(
            message: msg,
          ),
          type: PageTransitionType.downToUp,
        ),
      ),
    );
  }

  Widget buildTopContent() {
    return Container(
        width: _screenWidth,
        color: CustomText.textColor(FontColor.blue),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.02),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.message,
                  size: _screenHeight * 0.07,
                  color: CustomText.textColor(FontColor.white),
                ),
                Padding(padding: EdgeInsets.only(top: _screenHeight * 0.01)),
                CustomText(
                  text: "Les derniers messages",
                  fontColor: FontColor.white,
                  fontSize: FontSize.lg,
                  uppercase: true,
                  fontWeight: FontWeight.bold,
                )
              ],
            )));
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: CustomText.textColor(FontColor.lightBlue),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
              context: this.context,
              heightScreen: _screenHeight,
              widthScreen: _screenWidth),
          body: SmartRefresher(
            controller: _refreshController,
            enablePullUp: true,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              print("load");
            },
            child: ListView.builder(
                itemCount: messages == null ? 0 : messages.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: <Widget>[
                      (index == 0 ? buildTopContent() : Container()),
                      buildListMsg(messages[index])
                    ],
                  );
                }),
          ),
          bottomNavigationBar: CustomBottomBar(
              context: this.context,
              heightScreen: _screenHeight,
              widthScreen: _screenWidth),
        ),
      ),
    );
  }
}
