import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Goodie.dart';
import 'package:polypeip/pages/admin_pages/GoodiesEditPage.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodiesPage extends StatefulWidget {
  @override
  _GoodiesPageState createState() => _GoodiesPageState();
}

class _GoodiesPageState extends State<GoodiesPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Goodie> goodies;
  Color adminColor = Color(0xFF7f8fa6);

  @override
  void initState() {
    super.initState();

    getGoodies().then((value) {
      setState(() => goodies = value);
    });
  }

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
                imageUrl: goodies[index].img,
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
                    text: goodies[index].name,
                    fontColor: FontColor.black,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomText(
                    text: goodies[index].description,
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
                    text: goodies[index].price.toString() + '€',
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
                    onTap: () => Navigator.push(
                      context,
                      PageTransition(
                        child: GoodiesEditPage(
                          goodie: goodies[index],
                        ),
                        type: PageTransitionType.downToUp,
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(right: width * 0.012)),
                  GestureDetector(
                    child: Icon(Icons.delete, color: Colors.grey[800]),
                    onTap: () => removeGoodie(goodies[index].id).then(
                      (value) => setState(
                        () => goodies.removeAt(index),
                      ),
                    ),
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
            itemCount: goodies != null ? goodies.length : 0,
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
                  (index == (goodies != null ? goodies.length - 1 : 0))
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
