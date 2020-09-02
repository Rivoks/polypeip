import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomTextArea.dart';

import '../custom_widgets/CustomText.dart';

class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

String dropdownValue = 'Peip1A';

class _SigninPageState extends State<SigninPage> {
  TextEditingController nameTFC = TextEditingController();
  TextEditingController surnameTFC = TextEditingController();
  TextEditingController emailTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();
  TextEditingController password2TFC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    // Color blue = CustomText.textColor(FontColor.blue);

    return Container(
      color: CustomText.textColor(FontColor.blue),
      child: SafeArea(
        child: Scaffold(
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
                      text: "S'inscrire",
                      fontColor: FontColor.white,
                      fontSize: FontSize.xl,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextArea(
                    controller: nameTFC,
                    heightScreen: _screenHeight,
                    widthScreen: _screenWidth,
                    borderColor: Colors.white,
                    placeHolder: "Nom",
                    showSendIcon: false,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
                  CustomTextArea(
                    controller: surnameTFC,
                    heightScreen: _screenHeight,
                    widthScreen: _screenWidth,
                    borderColor: Colors.white,
                    placeHolder: "Prénom",
                    showSendIcon: false,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
                  CustomTextArea(
                    controller: emailTFC,
                    heightScreen: _screenHeight,
                    widthScreen: _screenWidth,
                    borderColor: Colors.white,
                    placeHolder: "adresse e-mail",
                    showSendIcon: false,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
                  DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_downward),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'Peip1A',
                      'Peip1B',
                      'Peip2A',
                      'Peip2B',
                      '3ST',
                      '3ROB',
                      '3AGRAL',
                      '3GM',
                      '3Ei2i',
                      '3MAIN',
                      '3MTX',
                      '4ST',
                      '4ROB',
                      '4AGRAL',
                      '4GM',
                      '4Ei2i',
                      '4MAIN',
                      '4MTX',
                      '5ST',
                      '5ROB',
                      '5AGRAL',
                      '5GM',
                      '5Ei2i',
                      '5MAIN',
                      '5MTX'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
                  CustomTextArea(
                    controller: passwordTFC,
                    heightScreen: _screenHeight,
                    widthScreen: _screenWidth,
                    borderColor: Colors.white,
                    placeHolder: "Mot de passe",
                    showSendIcon: false,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
                  CustomTextArea(
                    controller: password2TFC,
                    heightScreen: _screenHeight,
                    widthScreen: _screenWidth,
                    borderColor: Colors.white,
                    placeHolder: "Confirmez le mot de passe",
                    showSendIcon: false,
                  ),
                  Padding(
                      padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
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
        ),
      ),
    );
  }
}
