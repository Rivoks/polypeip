import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:page_transition/page_transition.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomBottomBarAlt.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Message.dart';
import 'package:polypeip/pages/PostMessagePage.dart';
import 'package:polypeip/pages/infoPages/InfoGoodiesPage.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageriePage extends StatefulWidget {
  @override
  _MessageriePageState createState() => _MessageriePageState();
}

class _MessageriePageState extends State<MessageriePage> {
  double _screenHeight;
  double _screenWidth;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  Color adminColor = Color(0xFF7f8fa6);

  List<Message> messages = [];

  String listChoice = "new";

  final double topBarHeightPercent = 0.06;

  void setPage() {
    getMessages().then((value) => setState(() => messages = value));
  }

  void initState() {
    super.initState();
    setPage();
  }

  Widget buildSlider(height, width) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return buildmessages(messages[index]);
      },
    );
  }

  Widget buildmessages(Message msg) {
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
                  text: msg.subject,
                  fontColor: FontColor.blue,
                  fontSize: FontSize.md,
                  fontWeight: FontWeight.bold,
                ),
                // CustomText(
                //   text: msg.sender,
                //   fontColor: FontColor.black,
                //   fontSize: FontSize.sm,
                //   fontWeight: FontWeight.bold,
                // ),
                CustomText(
                  text: msg.date.toIso8601String(),
                  fontColor: FontColor.darkGrey,
                  fontSize: FontSize.xs,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
          ],
        ),
      ),
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
        child: ListView(
          physics: ClampingScrollPhysics(),
          children: [
            Container(
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
                    Padding(
                        padding: EdgeInsets.only(top: _screenHeight * 0.01)),
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
            ),
            ...messages.map((e) => buildmessages(e)).toList(),
          ],
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
              ).then((value) => setPage());
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
