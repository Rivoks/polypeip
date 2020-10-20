import 'package:flutter/material.dart';
import 'package:polypeip/pages/LoginPage.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isTapped = false;
  String _currentSettings = "";
  SharedPreferences prefs;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  bool isAdmin = false;
  bool notifsActivated = false;

  @override
  void initState() {
    super.initState();
    setIsAdmin();
  }

  _launchURL() async {
    const url = 'mailto:<contact@polypeip.fr>';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  setIsAdmin() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isAdmin = prefs.getBool("isAdmin") == true ? true : false;
      notifsActivated = prefs.getBool("notifsActivated") == true ? true : false;
    });
  }

  Widget buildParamsContainer(height, width, textParams, last) {
    return GestureDetector(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                  top: BorderSide(color: Colors.grey[350], width: 0.5),
                  bottom: last
                      ? BorderSide(color: Colors.grey[350], width: 0.5)
                      : BorderSide.none)),
          width: width,
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.075,
            vertical: height * 0.032,
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 0.8 * width,
                child: CustomText(
                  text: textParams,
                  fontColor: FontColor.blue,
                  fontSize: FontSize.md,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Expanded(
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: CustomText.textColor(FontColor.blue),
                  size: height * 0.025,
                ),
              )
            ],
          )),
      onTap: () {
        setState(() {
          _isTapped = !_isTapped;
          _currentSettings = textParams;
        });
      },
    );
  }

  Widget singleAreaSetting(
      height, width, textParams, last, containerWidth, subChild) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                top: BorderSide(color: Colors.grey[350], width: 0.5),
                bottom: last
                    ? BorderSide(color: Colors.grey[350], width: 0.5)
                    : BorderSide.none)),
        width: width,
        padding: EdgeInsets.symmetric(
          horizontal: width * 0.075,
          vertical: height * 0.032,
        ),
        child: Row(
          children: <Widget>[
            Container(
              width: containerWidth * width,
              child: CustomText(
                text: textParams,
                fontColor: FontColor.blue,
                fontSize: FontSize.md,
                fontWeight: FontWeight.w600,
              ),
            ),
            Expanded(
              child: subChild,
            )
          ],
        ));
  }

  Widget buildSettings(height, width, page) {
    if (page == "Notifications") {
      return singleAreaSetting(
        height,
        width,
        "Activer les notifications",
        true,
        0.68,
        Switch(
            value: notifsActivated,
            onChanged: (_) {
              setNotifications(!notifsActivated, context: context).then(
                (value) => value == 200
                    ? setState(() {
                        prefs.setBool('notifsActivated', !notifsActivated);
                        notifsActivated = !notifsActivated;
                      })
                    : null,
              );
            }),
      );
    } else if (page == "Support") {
      return singleAreaSetting(
        height,
        width,
        "Contactez-nous",
        true,
        0.45,
        GestureDetector(
          child: CustomText(
            text: "contact@polypeip.fr",
            fontColor: FontColor.darkGrey,
            fontSize: FontSize.md,
          ),
          onTap: () {
            _launchURL();
          },
        ),
      );
    } else if (page == "À propos") {
      return singleAreaSetting(
        height,
        width,
        "Version de l'application",
        true,
        0.7,
        CustomText(
          text: "v 1.0.0",
          fontColor: FontColor.darkGrey,
          fontSize: FontSize.md,
        ),
      );
    } else if (page == "Admin") {
      if (!isAdmin) return Container();
      return Column(
        children: <Widget>[
          // singleAreaSetting(
          //   height,
          //   width,
          //   "Activités",
          //   false,
          //   0.7,
          //   GestureDetector(
          //     child: Icon(
          //       Icons.edit,
          //       color: CustomText.textColor(FontColor.blue),
          //       size: width * 0.055,
          //     ),
          //     onTap: () {
          //       Navigator.pushNamed(context, "/edit/activites");
          //     },
          //   ),
          // ),
          singleAreaSetting(
            height,
            width,
            "Evènements",
            false,
            0.7,
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: CustomText.textColor(FontColor.blue),
                size: width * 0.055,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/edit/events");
              },
            ),
          ),
          singleAreaSetting(
            height,
            width,
            "Annuaire",
            false,
            0.7,
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: CustomText.textColor(FontColor.blue),
                size: width * 0.055,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/edit/annuaire");
              },
            ),
          ),
          singleAreaSetting(
            height,
            width,
            "Réseaux sociaux",
            false,
            0.7,
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: CustomText.textColor(FontColor.blue),
                size: width * 0.055,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/edit/reseaux");
              },
            ),
          ),
          singleAreaSetting(
            height,
            width,
            "Plans & EDT",
            false,
            0.7,
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: CustomText.textColor(FontColor.blue),
                size: width * 0.055,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/edit/planEdt");
              },
            ),
          ),
          singleAreaSetting(
            height,
            width,
            "Goodies",
            true,
            0.7,
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: CustomText.textColor(FontColor.blue),
                size: width * 0.055,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/edit/goodies");
              },
            ),
          ),
          singleAreaSetting(
            height,
            width,
            "Messagerie",
            true,
            0.7,
            GestureDetector(
              child: Icon(
                Icons.edit,
                color: CustomText.textColor(FontColor.blue),
                size: width * 0.055,
              ),
              onTap: () {
                Navigator.pushNamed(context, "/edit/messagerie");
              },
            ),
          ),
        ],
      );
    }
    return Container();
  }

  Widget buildTopContent(height, width) {
    return Container(
        width: width,
        color: CustomText.textColor(FontColor.blue),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.settings,
                  size: height * 0.07,
                  color: CustomText.textColor(FontColor.white),
                ),
                Padding(padding: EdgeInsets.only(top: height * 0.01)),
                CustomText(
                  text: "Paramètres",
                  fontColor: FontColor.white,
                  fontSize: FontSize.lg,
                  uppercase: true,
                  fontWeight: FontWeight.bold,
                )
              ],
            )));
  }

  Widget buildTopBar(height, width, currentSettings) {
    return GestureDetector(
        child: Container(
          color: Colors.grey[200],
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.04,
            vertical: height * 0.015,
          ),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.arrow_back_ios,
                size: height * 0.018,
                color: CustomText.textColor(FontColor.darkGrey),
              ),
              Padding(padding: EdgeInsets.only(right: width * 0.02)),
              CustomText(
                text: currentSettings,
                fontColor: FontColor.darkGrey,
                fontSize: FontSize.sm,
              )
            ],
          ),
        ),
        onTap: () {
          setState(() {
            _isTapped = !_isTapped;
          });
        });
  }

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
          backgroundColor: Colors.white,
          appBar: CustomBackAppBar(
              context: this.context,
              heightScreen: _screenHeight,
              widthScreen: _screenWidth),
          body: SmartRefresher(
            controller: _refreshController,
            enablePullUp: false,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            child: Container(
              height: _screenHeight * 0.8,
              child: _isTapped == false
                  ? Column(
                      children: <Widget>[
                        buildTopContent(_screenHeight, _screenWidth),
                        buildParamsContainer(
                          _screenHeight,
                          _screenWidth,
                          "Notifications",
                          false,
                        ),
                        buildParamsContainer(
                          _screenHeight,
                          _screenWidth,
                          "Support",
                          false,
                        ),
                        buildParamsContainer(
                          _screenHeight,
                          _screenWidth,
                          "À propos",
                          false,
                        ),
                        buildParamsContainer(
                          _screenHeight,
                          _screenWidth,
                          "Admin",
                          true,
                        ),
                        Expanded(
                          child: Align(
                            alignment: FractionalOffset.bottomCenter,
                            child: MaterialButton(
                              onPressed: () => {},
                              child: CustomRoundedButton(
                                screenHeight: _screenHeight,
                                screenWidth: _screenWidth,
                                buttonHeight: 0.02,
                                buttonWidth: 0.1,
                                text: "Déconnexion",
                                fontColor: FontColor.white,
                                fontWeight: FontWeight.w800,
                                backgroundColor:
                                    CustomText.textColor(FontColor.blue),
                                borderColor:
                                    CustomText.textColor(FontColor.blue),
                                onPressed: () {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          LoginPage(),
                                    ),
                                    ModalRoute.withName('/login'),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: _screenHeight * 0.05))
                      ],
                    )
                  : Column(
                      children: <Widget>[
                        buildTopContent(_screenHeight, _screenWidth),
                        buildTopBar(
                            _screenHeight, _screenWidth, _currentSettings),
                        buildSettings(
                            _screenHeight, _screenWidth, _currentSettings),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
