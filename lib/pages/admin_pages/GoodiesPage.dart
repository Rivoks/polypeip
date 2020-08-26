import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodiesPage extends StatefulWidget {
  @override
  _GoodiesPageState createState() => _GoodiesPageState();
}

class _GoodiesPageState extends State<GoodiesPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map<String, String>> goodies = [
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Goodies 1",
      "description":
          "Courte description d'un produit goodies s'arrêtant sur deux lignes grâce à un overflow ellipsis et un maxLines de 2",
      "price": "19.99",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Goodies 1",
      "description":
          "Courte description d'un produit goodies s'arrêtant sur deux lignes grâce à un overflow ellipsis et un maxLines de 2",
      "price": "19.99",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Goodies 1",
      "description":
          "Courte description d'un produit goodies s'arrêtant sur deux lignes grâce à un overflow ellipsis et un maxLines de 2",
      "price": "19.99",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Goodies 1",
      "description":
          "Courte description d'un produit goodies s'arrêtant sur deux lignes grâce à un overflow ellipsis et un maxLines de 2",
      "price": "19.99",
    },
  ];

  Color adminColor = Color(0xFF7f8fa6);

  Widget buildEditForm(height, width, index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        height: height * 0.15,
        width: width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          border: Border.all(color: Colors.grey[400], width: 0.3),
          borderRadius: BorderRadius.circular(13),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[400],
              blurRadius: 5, // has the effect of softening the shadow
              spreadRadius: -5, // has the effect of extending the shadow
              offset: Offset(
                0, // horizontal, move right 10
                8, // vertical, move down 10
              ),
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(13)),
              child: CachedNetworkImage(
                width: width * 0.22,
                height: height * 0.15,
                fit: BoxFit.cover,
                imageUrl: goodies[index]['imgURL'],
                placeholder: (context, url) {
                  return Container(
                      width: width * 0.22,
                      alignment: Alignment.center,
                      child: Container(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                      color: Colors.grey[400]);
                },
              ),
            ),
            Padding(padding: EdgeInsets.symmetric(horizontal: width * 0.015)),
            Container(
              width: width * 0.45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CustomText(
                    text: goodies[index]['title'],
                    fontColor: FontColor.black,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: goodies[index]['description'],
                    fontColor: FontColor.darkGrey,
                    fontSize: FontSize.sm,
                    fontWeight: FontWeight.w400,
                    maxLines: 2,
                    overflowStyle: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: height * 0.02),
                  ),
                  CustomText(
                    text: goodies[index]['price'] + '€',
                    fontColor: FontColor.black,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    child: Icon(Icons.edit, color: Colors.grey[800]),
                    onTap: () => {
                      Navigator.pushNamed(context, "/edit/editGoodies",
                          arguments: {"goodiesId": goodies[index]['_id']})
                    },
                  ),
                  Padding(padding: EdgeInsets.only(right: width * 0.012)),
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.grey[800]),
                    onTap: () => print("delete"),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAddButton(height, width) {
    return Container(
      child: CustomRoundedButton(
        screenHeight: height,
        screenWidth: width,
        buttonHeight: 0.03,
        buttonWidth: 0,
        text: "Ajouter un Goodies",
        fontColor: FontColor.blue,
        fontSize: FontSize.md,
        fontWeight: FontWeight.bold,
        backgroundColor: null,
        borderColor: CustomText.textColor(FontColor.blue),
        onPressed: () => {Navigator.pushNamed(context, "/edit/addGoodies")},
      ),
    );
  }

  Widget buildTopContent(height, width) {
    return Container(
      width: width,
      color: adminColor,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: height * 0.02),
        child: Column(
          children: <Widget>[
            Icon(
              FontAwesome.edit,
              size: height * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: height * 0.01)),
            CustomText(
              text: "gérer les activités",
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

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomBackAppBar(
          context: this.context,
          heightScreen: _screenHeight,
          widthScreen: _screenWidth),
      body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          enablePullUp: false,
          header: WaterDropMaterialHeader(),
          onRefresh: () async {
            await Future.delayed(Duration(milliseconds: 1000));
            _refreshController.refreshCompleted();
          },
          child: ListView.builder(
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
            itemCount: goodies.length,
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  (index == 0)
                      ? buildTopContent(_screenHeight, _screenWidth)
                      : Container(),
                  (index == 0)
                      ? Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: _screenHeight * 0.03,
                            horizontal: _screenWidth * 0.05,
                          ),
                          child: buildAddButton(_screenHeight, _screenWidth),
                        )
                      : Container(),
                  Padding(padding: EdgeInsets.only(top: _screenHeight * 0.03)),
                  buildEditForm(_screenHeight, _screenWidth, index),
                  (index == goodies.length - 1)
                      ? Padding(
                          padding: EdgeInsets.only(top: _screenHeight * 0.05))
                      : Container(),
                ],
              );
            },
          )),
    );
  }
}
