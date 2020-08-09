import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';

class CustomNews extends StatefulWidget {
  final double heightScreen;
  final double widthScreen;
  final String newsId;
  final String newsTitle;
  final String newsDescription;
  final String newsDate;
  final String newsImage;

  final imageHeight = 0.3;
  final imageWidth = 1;

  CustomNews({
    @required this.heightScreen,
    @required this.widthScreen,
    @required this.newsId,
    @required this.newsTitle,
    @required this.newsDescription,
    @required this.newsDate,
    @required this.newsImage,
  });

  @override
  _CustomNews createState() => _CustomNews();
}

class _CustomNews extends State<CustomNews> {
  GlobalKey _bottomInfoKey = new GlobalKey();
  GlobalKey _topInfoKey = new GlobalKey();

  bool _isLiked = false;
  bool _isDisliked = false;

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
              alignment: Alignment.center,
              child: Container(
                height: widget.widthScreen * 0.1,
                width: widget.widthScreen * 0.1,
                child: CircularProgressIndicator(
                  backgroundColor: Colors.white,
                ),
              ),
              height: imageHeight,
              width: imageWidth,
              color: Colors.grey[400]);
        },
      ),
      onTap: () {
        return Navigator.pushNamed(context, "/post",
            arguments: {"postId": widget.newsId});
      },
      onDoubleTap: () {
        setState(() {
          if (_isLiked) {
            _isLiked = false;
          } else {
            _isDisliked = false;
            _isLiked = true;
          }
        });
      },
    );
  }

  Widget topInfosNews() {
    return GestureDetector(
      child: Container(
          key: _topInfoKey,
          width: widget.widthScreen * widget.imageWidth,
          padding: EdgeInsets.symmetric(
              horizontal: 0, vertical: widget.widthScreen * 0.028),
          color: CustomText.textColor(FontColor.blue),
          child: CustomText(
            text: widget.newsTitle,
            fontColor: FontColor.white,
            fontSize: FontSize.lg,
            alignment: TextAlign.center,
            fontWeight: FontWeight.bold,
            uppercase: true,
          )),
      onTap: () {
        return Navigator.pushNamed(context, "/post",
            arguments: {"postId": widget.newsId});
      },
    );
  }

  Widget bottomInfoNews() {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: widget.widthScreen * 0.04),
          color: Colors.grey[100],
          width: widget.widthScreen * widget.imageWidth,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: widget.heightScreen * 0.02)),
              CustomText(
                text: widget.newsDate,
                fontColor: FontColor.darkGrey,
                fontSize: FontSize.xs,
              ),
              Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: widget.heightScreen * 0.015)),
              CustomText(
                text: widget.newsDescription,
                fontColor: FontColor.black,
                fontSize: FontSize.sm,
                alignment: TextAlign.start,
                maxLines: 3,
                overflowStyle: TextOverflow.ellipsis,
              ),
              Padding(
                  padding: EdgeInsetsDirectional.only(
                      top: widget.heightScreen * 0.02)),
              Container(
                  height: 1,
                  width: 0.9 * widget.widthScreen * widget.imageWidth,
                  color: Colors.grey[300]),
              Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      key: _bottomInfoKey,
                      children: <Widget>[
                        GestureDetector(
                          child: Container(
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  CustomText(
                                    text: "76",
                                    fontColor: _isLiked
                                        ? FontColor.blue
                                        : FontColor.darkGrey,
                                    fontSize: FontSize.md,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              widget.widthScreen * 0.01)),
                                  Icon(
                                    Icons.thumb_up,
                                    size: CustomText.textSize(FontSize.lg),
                                    color: _isLiked
                                        ? CustomText.textColor(FontColor.blue)
                                        : CustomText.textColor(
                                            FontColor.darkGrey),
                                  )
                                ]),
                          ),
                          onTap: () {
                            setState(() {
                              if (_isLiked) {
                                _isLiked = false;
                              } else {
                                _isDisliked = false;
                                _isLiked = true;
                              }
                            });
                          },
                        ),
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: widget.widthScreen * 0.03)),
                        GestureDetector(
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                CustomText(
                                  text: "34",
                                  fontColor: _isDisliked
                                      ? FontColor.blue
                                      : FontColor.darkGrey,
                                  fontSize: FontSize.md,
                                  fontWeight: FontWeight.bold,
                                ),
                                Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: widget.widthScreen * 0.01)),
                                Icon(
                                  Icons.thumb_down,
                                  size: CustomText.textSize(FontSize.lg),
                                  color: _isDisliked
                                      ? CustomText.textColor(FontColor.blue)
                                      : CustomText.textColor(
                                          FontColor.darkGrey),
                                )
                              ]),
                          onTap: () {
                            setState(() {
                              if (_isDisliked) {
                                _isDisliked = false;
                              } else {
                                _isDisliked = true;
                                _isLiked = false;
                              }
                            });
                          },
                        )
                      ]))
            ],
          )),
      onTap: () {
        return Navigator.pushNamed(context, "/post",
            arguments: {"postId": widget.newsId});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: Colors.grey[400],
              blurRadius: 5, // has the effect of softening the shadow
              spreadRadius: -5, // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                12, // vertical, move down 10
              ))
        ]),
        width: widget.widthScreen,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[topInfosNews(), newsPoster(), bottomInfoNews()],
        ));
  }
}
