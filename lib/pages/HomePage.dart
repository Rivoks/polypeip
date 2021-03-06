import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_widgets/CustomAppBar.dart';
import 'package:polypeip/custom_widgets/CustomBottomBar.dart';
import 'package:polypeip/custom_widgets/CustomNews.dart';
import 'package:polypeip/custom_widgets/CustomNewsAlt.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Post.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:polypeip/services/requests.dart';
import '../custom_widgets/CustomTopbar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<Post> posts;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  String listChoice = "cards";
  CarouselController buttonCarouselController = CarouselController();

  final double topBarHeightPercent = 0.06;

  @override
  void initState() {
    super.initState();
    getPosts(context: context).then((value) {
      setState(() => posts = value);
    });
  }

  Widget constructTopBar(heightScreen, widthScreen) {
    double topBarHeight = heightScreen * topBarHeightPercent;

    return new CustomTopbar(
      context: context,
      widthScreen: widthScreen,
      heightScreen: heightScreen,
      appBarHeight: topBarHeightPercent,
      topBarChild: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              if (listChoice != "cards") {
                buttonCarouselController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
                setState(() {
                  listChoice = "cards";
                });
              }
            },
            child: new Container(
                alignment: Alignment.center,
                color: Colors.white,
                width: widthScreen / 2,
                padding: EdgeInsets.only(left: widthScreen / 8),
                height: topBarHeight,
                child: Icon(Icons.web_asset,
                    size: CustomText.textSize(FontSize.xl),
                    color: listChoice == "lines"
                        ? Colors.grey
                        : CustomText.textColor(FontColor.blue))),
          ),
          new GestureDetector(
            onTap: () {
              if (listChoice != "lines") {
                buttonCarouselController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
                setState(() {
                  listChoice = "lines";
                });
              }
            },
            child: new Container(
                color: Colors.white,
                width: widthScreen / 2,
                height: topBarHeight,
                padding: EdgeInsets.only(right: widthScreen / 8),
                alignment: Alignment.center,
                child: Icon(Icons.view_list,
                    size: CustomText.textSize(FontSize.xl),
                    color: listChoice == "cards"
                        ? Colors.grey
                        : CustomText.textColor(FontColor.blue))),
          ),
        ],
      ),
    );
  }

  CarouselSlider buildSlider(height, width) {
    return CarouselSlider(
      carouselController: buttonCarouselController,
      options: CarouselOptions(
        height: height,
        viewportFraction: 1.0,
        enableInfiniteScroll: false,
        autoPlay: false,
        scrollPhysics: ClampingScrollPhysics(),
        onPageChanged: (page, changeReason) {
          setState(() {
            if (page == 0)
              listChoice = "cards";
            else
              listChoice = "lines";
          });
        },
      ),
      items: [
        ListView.builder(
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: index != 0 ? null : EdgeInsets.only(top: height * 0.03),
                padding: EdgeInsets.symmetric(horizontal: width * 0.08),
                width: width,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(bottom: height * 0.04),
                  child: CustomNews(
                    heightScreen: height,
                    widthScreen: width,
                    post: posts[index],
                  ),
                ),
              );
            }),
        ListView.builder(
            itemCount: posts == null ? 0 : posts.length,
            itemBuilder: (context, index) {
              return Container(
                margin: index != 0 ? null : EdgeInsets.only(top: height * 0.03),
                width: width,
                color: Colors.white,
                child: Container(
                  margin: EdgeInsets.only(bottom: height * 0.03),
                  child: CustomNewsAlt(
                    heightScreen: height,
                    widthScreen: width,
                    post: posts[index],
                  ),
                ),
              );
            })
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    double _carouselHeight =
        _screenHeight - _screenHeight * (topBarHeightPercent + 0.2);

    return Container(
      color: CustomText.textColor(FontColor.lightBlue),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: Colors.white,
          appBar: CustomAppBar(
            context: this.context,
            heightScreen: _screenHeight,
            widthScreen: _screenWidth,
          ),
          body: SmartRefresher(
            controller: _refreshController,
            enablePullDown: true,
            enablePullUp: false,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            child: new Stack(children: <Widget>[
              constructTopBar(_screenHeight, _screenWidth),
              Padding(
                padding:
                    EdgeInsets.only(top: _screenHeight * topBarHeightPercent),
                child: buildSlider(_carouselHeight, _screenWidth),
              ),
            ]),
          ),
          bottomNavigationBar: CustomBottomBar(
              context: this.context,
              heightScreen: _screenHeight,
              widthScreen: _screenWidth),
        ),
      ),
    );
  }
}
