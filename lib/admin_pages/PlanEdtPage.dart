import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class PlanEdtPage extends StatefulWidget {
  @override
  _PlanEdtPageState createState() => _PlanEdtPageState();
}

class _PlanEdtPageState extends State<PlanEdtPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Map<String, String>> planJussieu = [
    {
      "_id": "6az4e6aze4a",
      "caption": "Plan de la fac",
      "imgURL":
          "https://www.cfa-sciences.fr/sites/default/files/thumbnails/image/Plan%20CFA%20des%20Sciences_0.png",
    },
  ];

  List<Map<String, String>> edtImg = [
    {
      "_id": "6az4e6aze4a",
      "caption": "EDT Peip1A",
      "imgURL":
          "https://i.pinimg.com/originals/2f/ba/fe/2fbafe988de1dd4673c95670b8b58b52.jpg",
    },
    {
      "_id": "6az4e6aze4a",
      "caption": "EDT Peip1B",
      "imgURL":
          "https://www.a-qui-s.fr/le-blog/wp-content/uploads/2017/09/emploi-du-temps.png",
    },
  ];

  Color adminColor = Color(0xFF7f8fa6);

  Widget buildEditForm(height, width, table, index) {
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
                imageUrl: table[index]['imgURL'],
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
                    text: table[index]['caption'],
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
                      Navigator.pushNamed(context, "/edit/editPlanEdt",
                          arguments: {"planEdtId": table[index]['_id']})
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
        text: "Ajouter un emploi du temps",
        fontColor: FontColor.blue,
        fontSize: FontSize.md,
        fontWeight: FontWeight.bold,
        backgroundColor: null,
        borderColor: CustomText.textColor(FontColor.blue),
        onPressed: () => {Navigator.pushNamed(context, "/edit/addPlanEdt")},
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
              text: "gérer les plans et les EDT",
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
            itemCount: edtImg.length,
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
                  (index == 0)
                      ? Column(
                          children: <Widget>[
                            buildEditForm(
                                _screenHeight, _screenWidth, planJussieu, 0),
                            Container(
                              margin:
                                  EdgeInsets.only(top: _screenHeight * 0.03),
                              color: Colors.grey[350],
                              width: _screenWidth * 0.92,
                              height: 1,
                            )
                          ],
                        )
                      : Container(),
                  Padding(padding: EdgeInsets.only(top: _screenHeight * 0.03)),
                  buildEditForm(_screenHeight, _screenWidth, edtImg, index),
                  (index == edtImg.length - 1)
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
