import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomTextArea.dart';

import 'custom_widgets/CustomText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    // Color blue = CustomText.textColor(FontColor.blue);

    return Scaffold(
      body: Container(
          padding: EdgeInsets.symmetric(
            horizontal: _screenWidth * 0.1,
          ),
          height: _screenHeight,
          width: _screenWidth,
          color: Colors.blue,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(bottom: _screenHeight * 0.02),
                child: Image.asset(
                  "assets/img/logo_alt.png",
                  height: _screenHeight * 0.17,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: _screenHeight * 0.1),
                child: CustomText(
                  text: "Se Connecter",
                  fontColor: FontColor.white,
                  fontSize: FontSize.xl,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextArea(
                heightScreen: _screenHeight,
                widthScreen: _screenWidth,
                borderColor: Colors.white,
                placeHolder: "Numéro étudiant",
                showSendIcon: false,
              ),
              Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
              CustomTextArea(
                heightScreen: _screenHeight,
                widthScreen: _screenWidth,
                borderColor: Colors.white,
                placeHolder: "Mot de passe",
                showSendIcon: false,
              ),
              Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
              CustomRoundedButton(
                screenHeight: _screenHeight,
                screenWidth: _screenWidth,
                buttonHeight: 0.02,
                buttonWidth: 0.1,
                text: "Connexion",
                fontColor: FontColor.blue,
                fontWeight: FontWeight.bold,
                backgroundColor: Colors.white,
                borderColor: Colors.white,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/home");
                },
              ),
            ],
          )),
    );
  }
}
