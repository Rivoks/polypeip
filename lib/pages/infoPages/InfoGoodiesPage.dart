import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Goodie.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfoGoodiesPage extends StatefulWidget {
  @override
  _InfoGoodiesPageState createState() => _InfoGoodiesPageState();
}

Color blue = CustomText.textColor(FontColor.blue);

class _InfoGoodiesPageState extends State<InfoGoodiesPage> {
  List<Goodie> goodies;

  @override
  void initState() {
    super.initState();

    getGoodies(context: context).then((res) {
      setState(() => goodies = res);
    });
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  Widget buildGoodiesCard(height, width) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: goodies != null ? goodies.length : 0,
      itemBuilder: (container, index) {
        Goodie goodie = goodies[index];

        return Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                height: height * 0.3,
                width: width,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return DetailScreen(img: goodie.img);
                        },
                      ),
                    );
                  },
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: goodie.img,
                    placeholder: (context, url) {
                      return Container(
                          alignment: Alignment.center,
                          child: Container(
                            height: width * 0.1,
                            width: width * 0.1,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          height: height * 0.3,
                          width: width,
                          color: Colors.grey[400]);
                    },
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(
                      color: Colors.grey[500],
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(8),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey[400],
                          blurRadius:
                              5, // has the effect of softening the shadow
                          spreadRadius:
                              -5, // has the effect of extending the shadow
                          offset: Offset(
                            0, // horizontal, move right 10
                            12, // vertical, move down 10
                          ))
                    ]),
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: height * 0.025),
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomText(
                      text: goodie.name,
                      fontColor: FontColor.blue,
                      fontSize: FontSize.xl,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: height * 0.007)),
                    CustomText(
                      text: goodie.description,
                      fontColor: FontColor.darkGrey,
                      fontSize: FontSize.sm,
                      fontWeight: FontWeight.w400,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: height * 0.02)),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: height * 0.02),
                      child: Container(
                        color: Colors.grey[300],
                        width: width,
                        height: 1,
                      ),
                    ),
                    CustomText(
                      text: 'Prix : ' + goodie.price.toString() + '€',
                      fontColor: FontColor.darkGrey,
                      fontSize: FontSize.lg,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.03),
              ),
            ],
          ),
        );
      },
    );
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
              FontAwesome.shopping_bag,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "Goodies Polypeip",
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
          body: SmartRefresher(
            controller: _refreshController,
            enablePullUp: false,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    buildTopContent(_screenHeight, _screenWidth),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: _screenHeight * 0.02)),
                    buildGoodiesCard(_screenHeight, _screenWidth),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  final String img;

  DetailScreen({@required this.img});

  @override
  Widget build(BuildContext context) {
    double _screenHeight = MediaQuery.of(context).size.height;
    double _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: CustomBackAppBar(
          backgroundColor: Colors.black,
          context: context,
          heightScreen: _screenHeight,
          widthScreen: _screenWidth),
      body: GestureDetector(
        child: Center(
          child: Hero(
            tag: 'imageHero',
            child: PhotoView(
              minScale: 0.55,
              maxScale: 1.2,
              imageProvider: NetworkImage(img),
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
