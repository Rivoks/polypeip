import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Edt.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class InfoEdtPage extends StatefulWidget {
  @override
  _InfoEdtPageState createState() => _InfoEdtPageState();
}

RefreshController _refreshController = RefreshController(initialRefresh: false);

class _InfoEdtPageState extends State<InfoEdtPage> {
  List<Edt> edts = [];

  @override
  void initState() {
    super.initState();

    getEdts(context: context).then((value) => setState(() => edts = value));
  }

  Widget buildImageMap(height, width) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: edts == null ? 0 : edts.length,
      itemBuilder: (container, index) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.08),
          child: GestureDetector(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: height * 0.3,
                  width: width,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: edts[index].img,
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
                Padding(padding: EdgeInsets.only(top: height * 0.015)),
                CustomText(
                  text: edts[index].name,
                  fontColor: FontColor.darkGrey,
                  fontSize: FontSize.md,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: height * 0.03),
                  child: Container(
                    color: (index == edts.length - 1)
                        ? Colors.grey[0]
                        : Colors.grey[200],
                    width: width,
                    height: 1,
                  ),
                ),
              ],
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailScreen(
                  img: edts[index].img,
                );
              }));
            },
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
              FontAwesome.calendar_minus_o,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "Emplois du temps",
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
                    buildImageMap(_screenHeight, _screenWidth),
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
