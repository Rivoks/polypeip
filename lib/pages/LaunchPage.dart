import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../custom_widgets/CustomText.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  SharedPreferences prefs;

  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      prefs = await SharedPreferences.getInstance();
      String token = prefs.getString('token');
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(
            context, token != null ? '/home' : '/login');
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: CustomText.textColor(FontColor.blue),
      child: SafeArea(
        child: Scaffold(
          body: Center(
              child: Container(
            padding: EdgeInsets.all(100),
            height: _screenHeight,
            width: _screenWidth,
            color: CustomText.textColor(FontColor.blue),
            child: Image.asset("assets/img/logo_alt.png"),
          )),
        ),
      ),
    );
  }
}
