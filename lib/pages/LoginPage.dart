import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomTextArea.dart';

import '../custom_widgets/CustomText.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailTFC = TextEditingController();
  TextEditingController passwordTFC = TextEditingController();

// Future _signin() async {
//     emailFocus.unfocus();
//     psswdFocus.unfocus();
//     if (!_formKey.currentState.validate()) return;
//     _formKey.currentState.save();
//     setState(() => loading = true);

//     final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//     try {
//       final device = await _firebaseMessaging.getToken();
//       print(device);
//       var res = await request(
//         RequestType.post,
//         '/authentications/login',
//         body: {
//           "email": email.trim(),
//           "password": password,
//           "deviceFCM": device
//         },
//       );

//       if (res['status'] == 401) {
//         setState(() => error = true);
//         return;
//       }
//       prefs.setString('token', res['data']['token']);

//       Navigator.of(context).pushNamedAndRemoveUntil(
//         "/",
//         (Route<dynamic> route) => false,
//       );
//       setState(() => error = false);
//     } catch (e) {
//       setState(() => error = true);
//     }
//     setState(() => loading = false);
//   }

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
                      text: "Se Connecter",
                      fontColor: FontColor.white,
                      fontSize: FontSize.xl,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextArea(
                    controller: emailTFC,
                    heightScreen: _screenHeight,
                    widthScreen: _screenWidth,
                    borderColor: Colors.white,
                    placeHolder: "Adresse e-mail",
                    showSendIcon: false,
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
                  CustomRoundedButton(
                    screenHeight: _screenHeight,
                    screenWidth: _screenWidth,
                    buttonHeight: 0.02,
                    buttonWidth: 0.1,
                    text: "Inscription",
                    fontColor: FontColor.blue,
                    fontWeight: FontWeight.bold,
                    backgroundColor: Colors.white,
                    borderColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, "/signin");
                    },
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
