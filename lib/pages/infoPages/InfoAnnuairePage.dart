import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Contact.dart';
import 'package:polypeip/models/Link.dart';
import 'package:polypeip/models/SocialNetwork.dart';
import 'package:polypeip/services/requests.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoAnnuairePage extends StatefulWidget {
  @override
  _InfoAnnuairePageState createState() => _InfoAnnuairePageState();
}

class _InfoAnnuairePageState extends State<InfoAnnuairePage> {
  bool _isTapped = false;
  String _currentSettings = "";
  bool loading = false;

  List<Contact> contacts;
  List<SocialNetwork> socialNetworks;
  List<Link> links;

  Future setContacts() async {
    if (contacts != null) return;
    List<Contact> tmp = await getContacts(context: context);
    setState(() => contacts = tmp);
  }

  Future setSocailNetworks() async {
    if (socialNetworks != null) return;
    List<SocialNetwork> tmp = await getSocialNetworks(context: context);
    setState(() => socialNetworks = tmp);
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
              bottom: BorderSide(color: Colors.grey[350], width: 0.5),
            )),
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

  Widget buildAnnuaire(height, width, page) {
    setState(() => loading = true);

    switch (page) {
      case "Contact":
        setContacts();
        return ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: contacts == null ? 0 : contacts.length,
            itemBuilder: (context, index) {
              Contact contact = contacts[index];

              return singleAreaSetting(
                height,
                width,
                contact.name,
                false,
                0.45,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: CustomText(
                        text: 'Tel :' + contact.tel,
                        fontColor: FontColor.darkGrey,
                        fontSize: FontSize.md,
                        fontWeight: FontWeight.bold,
                      ),
                      onTap: () {
                        launch('tel:<' + contact.tel + '>');
                      },
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(vertical: width * 0.01)),
                    GestureDetector(
                      child: CustomText(
                        text: contact.email,
                        fontColor: FontColor.darkGrey,
                        fontSize: FontSize.md,
                      ),
                      onTap: () {
                        launch('mailto:<' + contact.email + '>');
                      },
                    )
                  ],
                ),
              );
            });
        break;
      case "Réseaux sociaux":
        setSocailNetworks();
        return ListView.builder(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          itemCount: socialNetworks == null ? 0 : socialNetworks.length,
          itemBuilder: (context, index) {
            SocialNetwork social = socialNetworks[index];

            return singleAreaSetting(
              height,
              width,
              social.socialNetwork,
              false,
              0.45,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: CustomText(
                      text: social.username,
                      fontColor: FontColor.darkGrey,
                      fontSize: FontSize.md,
                      fontWeight: FontWeight.bold,
                    ),
                    onTap: () {
                      // launch(social.url);
                    },
                  ),
                ],
              ),
            );
          },
        );
        break;
      default:
        return Container();
    }
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
              FontAwesome.book,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "Annuaire",
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
      },
    );
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
          body: Container(
            child: _isTapped == false
                ? Column(
                    children: <Widget>[
                      buildTopContent(_screenHeight, _screenWidth),
                      buildParamsContainer(
                        _screenHeight,
                        _screenWidth,
                        "Contact",
                        false,
                      ),
                      buildParamsContainer(
                        _screenHeight,
                        _screenWidth,
                        "Réseaux sociaux",
                        false,
                      ),
                      buildParamsContainer(
                        _screenHeight,
                        _screenWidth,
                        "Liens utiles",
                        true,
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
                      buildAnnuaire(
                          _screenHeight, _screenWidth, _currentSettings)
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
