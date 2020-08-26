import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ActivitesPage extends StatefulWidget {
  @override
  _ActivitesPageState createState() => _ActivitesPageState();
}

class _ActivitesPageState extends State<ActivitesPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map<String, String>> activites = [
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Quais St Bernard",
      "date": "07/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "https://static.wixstatic.com/media/159423_4b37bee76b6949d282a5c40372bf35bf.jpg/v1/fill/w_920,h_555,al_c,q_85,usm_0.66_1.00_0.01/159423_4b37bee76b6949d282a5c40372bf35bf.webp",
      "title": "Cave escalgon",
      "date": "05/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "https://lh3.googleusercontent.com/proxy/4Fxb_QU6q_MHp6iUx0R1E6A181Ftxs9jDEM8GpiaerN5cc52jY8Kt2nmuPQqf1Sqngj0gWt09MPgeeQX7ZbLEH9DXtE9mzqgAe8GeVjbndO2YsAh_d1vCzOEg4SdBW24f1mFlykoqobFP5-s5w",
      "title": "Arènes de Lutèce",
      "date": "03/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Quais St Bernard",
      "date": "07/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "https://static.wixstatic.com/media/159423_4b37bee76b6949d282a5c40372bf35bf.jpg/v1/fill/w_920,h_555,al_c,q_85,usm_0.66_1.00_0.01/159423_4b37bee76b6949d282a5c40372bf35bf.webp",
      "title": "Cave escalgon",
      "date": "05/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "https://lh3.googleusercontent.com/proxy/4Fxb_QU6q_MHp6iUx0R1E6A181Ftxs9jDEM8GpiaerN5cc52jY8Kt2nmuPQqf1Sqngj0gWt09MPgeeQX7ZbLEH9DXtE9mzqgAe8GeVjbndO2YsAh_d1vCzOEg4SdBW24f1mFlykoqobFP5-s5w",
      "title": "Arènes de Lutèce",
      "date": "03/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "http://www.leparisien.fr/resizer/xZzzRB8GLppx_dJSx7UZBfqI-Ik=/932x582/arc-anglerfish-eu-central-1-prod-leparisien.s3.amazonaws.com/public/O32M647E2KFNO2XYOPUINMLEY4.jpg",
      "title": "Quais St Bernard",
      "date": "07/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "https://static.wixstatic.com/media/159423_4b37bee76b6949d282a5c40372bf35bf.jpg/v1/fill/w_920,h_555,al_c,q_85,usm_0.66_1.00_0.01/159423_4b37bee76b6949d282a5c40372bf35bf.webp",
      "title": "Cave escalgon",
      "date": "05/05/2020",
    },
    {
      "_id": "4za64da94az",
      "imgURL":
          "https://lh3.googleusercontent.com/proxy/4Fxb_QU6q_MHp6iUx0R1E6A181Ftxs9jDEM8GpiaerN5cc52jY8Kt2nmuPQqf1Sqngj0gWt09MPgeeQX7ZbLEH9DXtE9mzqgAe8GeVjbndO2YsAh_d1vCzOEg4SdBW24f1mFlykoqobFP5-s5w",
      "title": "Arènes de Lutèce",
      "date": "03/05/2020",
    },
  ];

  Color adminColor = Color(0xFF7f8fa6);

  Widget buildEditForm(height, width, index) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: width * 0.05),
      child: Container(
        height: height * 0.1,
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
                ))
          ],
        ),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(13)),
              child: CachedNetworkImage(
                width: width * 0.22,
                height: height * 0.1,
                fit: BoxFit.cover,
                imageUrl: activites[index]['imgURL'],
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
                    text: activites[index]['title'],
                    fontColor: FontColor.black,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: activites[index]['date'],
                    fontColor: FontColor.black,
                    fontSize: FontSize.sm,
                    fontWeight: FontWeight.w400,
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
                      Navigator.pushNamed(context, "/edit/editActivite",
                          arguments: {"activiteId": activites[index]['_id']})
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
        text: "Ajouter une activité",
        fontColor: FontColor.blue,
        fontSize: FontSize.md,
        fontWeight: FontWeight.bold,
        backgroundColor: null,
        borderColor: CustomText.textColor(FontColor.blue),
        onPressed: () => {Navigator.pushNamed(context, "/edit/addActivite")},
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
            itemCount: activites.length,
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
                  (index == activites.length - 1)
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
