import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class CustomNewsAlt extends StatefulWidget {
  final double heightScreen;
  final double widthScreen;
  final String newsId;
  final String newsTitle;
  final String newsDescription;
  final DateTime newsDate;
  final String newsImage;

  final imageHeight = 0.2;
  final imageWidth = 0.3;

  CustomNewsAlt({
    @required this.heightScreen,
    @required this.widthScreen,
    @required this.newsId,
    @required this.newsTitle,
    @required this.newsDescription,
    @required this.newsDate,
    @required this.newsImage,
  });

  @override
  _CustomNewsAlt createState() => _CustomNewsAlt();
}

class _CustomNewsAlt extends State<CustomNewsAlt> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Widget newsPoster() {
    double imageHeight = widget.imageHeight * widget.heightScreen;
    double imageWidth = widget.imageWidth * widget.widthScreen;

    return GestureDetector(
      child: CachedNetworkImage(
        imageUrl: widget.newsImage,
        height: imageHeight,
        width: imageWidth,
        fit: BoxFit.fill,
        placeholder: (context, url) {
          return Container(
              height: imageHeight, width: imageWidth, color: Colors.grey[400]);
        },
      ),
      onTap: () {
        return Navigator.pushNamed(context, "/post",
            arguments: {"postId": widget.newsId});
      },
    );
  }

  Widget containerInfoNews() {
    return GestureDetector(
        child: Container(
            padding:
                EdgeInsets.symmetric(horizontal: widget.widthScreen * 0.01),
            color: Colors.grey[200],
            height: widget.heightScreen * widget.imageHeight,
            width: 0.95 * widget.widthScreen -
                widget.widthScreen * widget.imageWidth,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.heightScreen * 0.02,
                      left: widget.widthScreen * 0.03),
                  child: CustomText(
                    text: widget.newsTitle,
                    fontColor: FontColor.black,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                    alignment: TextAlign.start,
                    maxLines: 3,
                    overflowStyle: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.heightScreen * 0.01,
                      left: widget.widthScreen * 0.03),
                  child: CustomText(
                    text: widget.newsDate.toIso8601String(),
                    fontColor: FontColor.darkGrey,
                    fontSize: FontSize.xs,
                    alignment: TextAlign.start,
                    maxLines: 3,
                    overflowStyle: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: widget.heightScreen * 0.05,
                      left: widget.widthScreen * 0.03),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      CustomText(
                        text: "76",
                        fontColor: FontColor.darkGrey,
                        fontSize: FontSize.xs,
                        fontWeight: FontWeight.w900,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.widthScreen * 0.005)),
                      Icon(Icons.thumb_up,
                          size: CustomText.textSize(FontSize.sm),
                          color: CustomText.textColor(FontColor.darkGrey)),
                      Padding(
                          padding: EdgeInsets.only(
                              right: widget.widthScreen * 0.04)),
                      // - //
                      CustomText(
                        text: "18",
                        fontColor: FontColor.darkGrey,
                        fontSize: FontSize.xs,
                        fontWeight: FontWeight.w900,
                      ),
                      Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: widget.widthScreen * 0.005)),
                      Icon(Icons.thumb_down,
                          size: CustomText.textSize(FontSize.sm),
                          color: CustomText.textColor(FontColor.darkGrey)),
                      Padding(
                          padding: EdgeInsets.only(
                              right: widget.widthScreen * 0.04)),
                    ],
                  ),
                ),
              ],
            )),
        onTap: () {
          return Navigator.pushNamed(context, "/post",
              arguments: {"postId": widget.newsId});
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey[350],
              blurRadius: 5, // has the effect of softening the shadow
              spreadRadius: -5, // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                12, // vertical, move down 10
              ))
        ]),
        width: widget.widthScreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[newsPoster(), containerInfoNews()],
        ));
  }
}
