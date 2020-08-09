import 'package:flutter/material.dart';

class CustomTextArea extends StatelessWidget {
  final double heightScreen;
  final double widthScreen;
  final Color inputColor;
  final Color borderColor;
  final String placeHolder;
  final int maxLines;
  final bool showSendIcon;
  final TextInputAction inputType;

  CustomTextArea({
    @required this.heightScreen,
    @required this.widthScreen,
    @required this.borderColor,
    @required this.placeHolder,
    @required this.showSendIcon,
    this.inputColor = Colors.white,
    this.maxLines = 1,
    this.inputType = TextInputAction.done,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 2,
            color: this.borderColor,
          ),
          borderRadius: BorderRadius.circular(this.widthScreen * 0.08),
        ),
        width: this.widthScreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Expanded(
              child: TextField(
                textInputAction: this.inputType,
                minLines: 1,
                maxLines: this.maxLines,
                style: TextStyle(color: this.inputColor),
                cursorColor: this.inputColor,
                cursorWidth: 2,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: this.placeHolder,
                  hintStyle: TextStyle(
                    color: this.borderColor.withOpacity(0.6),
                    fontStyle: FontStyle.italic,
                  ),
                  contentPadding:
                      EdgeInsets.only(left: this.widthScreen * 0.05),
                ),
              ),
            ),
            (this.showSendIcon == true)
                ? Padding(
                    padding: EdgeInsets.only(right: this.widthScreen * 0.03),
                    child: GestureDetector(
                      child: Icon(
                        Icons.send,
                        color: this.borderColor,
                      ),
                      onTap: () => print("tap"),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.only(right: this.widthScreen * 0.05)),
          ],
        ),
      ),
    );
  }
}
