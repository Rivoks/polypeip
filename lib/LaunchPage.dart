import 'package:flutter/material.dart';

import 'custom_widgets/CustomText.dart';

class LaunchPage extends StatefulWidget {
  @override
  _LaunchPageState createState() => _LaunchPageState();
}

class _LaunchPageState extends State<LaunchPage> {
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Future.delayed(const Duration(milliseconds: 1000), () {
        Navigator.pushReplacementNamed(context, '/home');
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
