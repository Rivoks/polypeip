import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Goodie.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class GoodiesEditPage extends StatefulWidget {
  GoodiesEditPage({@required this.goodie});

  final Goodie goodie;

  @override
  _GoodiesEditPageState createState() => _GoodiesEditPageState();
}

class _GoodiesEditPageState extends State<GoodiesEditPage> {
  File _image;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController nameTFC = TextEditingController();
  TextEditingController descriptionTFC = TextEditingController();
  TextEditingController priceTFC = TextEditingController();

  double _screenHeight;
  double _screenWidth;

  double spaceInput = 0.1;

  Color blue = CustomText.textColor(FontColor.blue);

  Color adminColor = Color(0xFF7f8fa6);

  @override
  void initState() {
    super.initState();

    nameTFC.text = widget.goodie.name;
    descriptionTFC.text = widget.goodie.description;
    priceTFC.text = widget.goodie.price.toString();
  }

  Future imageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  Future imageGallery() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  void showSimpleCustomDialog(BuildContext context) {
    Dialog simpleDialog = Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: _screenHeight * 0.02,
          horizontal: _screenWidth * 0.015,
        ),
        height: _screenHeight * 0.3,
        width: _screenHeight * 0.3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(15.0),
              child: CustomText(
                text:
                    "Ajoute l'image depuis ta gallerie ou prends direct en photo !",
                fontColor: FontColor.darkGrey,
                fontSize: FontSize.md,
                fontWeight: FontWeight.w500,
                alignment: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: _screenHeight * 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: _screenHeight * 0.01),
                    color: Colors.blue,
                    onPressed: () {
                      imageCamera();
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.photo_camera,
                      size: _screenHeight * 0.05,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  RaisedButton(
                    padding:
                        EdgeInsets.symmetric(vertical: _screenHeight * 0.01),
                    color: Colors.blue,
                    onPressed: () {
                      imageGallery();
                      Navigator.of(context).pop();
                    },
                    child: Icon(
                      Icons.photo_album,
                      size: _screenHeight * 0.05,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context, builder: (BuildContext context) => simpleDialog);
  }

  Widget buildTopContent() {
    return Container(
      height: _screenHeight * 0.154,
      width: _screenWidth,
      color: adminColor,
      child: (_image == null)
          ? Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.01),
                ),
                Icon(
                  FontAwesome.edit,
                  size: _screenHeight * 0.07,
                  color: CustomText.textColor(FontColor.white),
                ),
                Padding(padding: EdgeInsets.only(top: _screenHeight * 0.01)),
                CustomText(
                  text: "modifier un goodies",
                  fontColor: FontColor.white,
                  fontSize: FontSize.lg,
                  uppercase: true,
                  fontWeight: FontWeight.bold,
                )
              ],
            )
          : Image.file(
              _image,
              fit: BoxFit.cover,
            ),
    );
  }

  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _screenWidth * 0.08, vertical: _screenHeight * 0.04),
      child: CustomText(
        text: "Remplissez les champs pour modifier un Goodies",
        fontColor: FontColor.darkGrey,
        fontSize: FontSize.md,
        fontWeight: FontWeight.w500,
        alignment: TextAlign.center,
      ),
    );
  }

  Widget buildSubmitButton() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.15),
      child: CustomRoundedButton(
        screenHeight: _screenHeight,
        screenWidth: _screenWidth,
        buttonHeight: 0.02,
        buttonWidth: 0,
        text: "Modifier",
        fontColor: FontColor.white,
        fontWeight: FontWeight.bold,
        backgroundColor: blue,
        borderColor: blue,
        onPressed: () => editGoodie(
          widget.goodie.id,
          nameTFC.text,
          descriptionTFC.text,
          priceTFC.text,
          _image,
        ).then(
          (value) => Navigator.pop(context),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: _screenWidth * 0.08),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: nameTFC,
            decoration: InputDecoration(
              hintText: "Titre du produit",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
          TextField(
            controller: descriptionTFC,
            minLines: 1,
            maxLines: null,
            onChanged: (_) => {
              setState(() {
                spaceInput = 0;
              })
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.only(bottom: _screenHeight * spaceInput),
              hintText: "Description de l'activité",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.03)),
          Container(
            width: _screenWidth,
            child: Row(
              children: <Widget>[
                Container(
                  width: _screenWidth * 0.4,
                  child: TextField(
                    controller: priceTFC,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Prix du produit",
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CustomText(
                    text: "€",
                    fontColor: FontColor.darkGrey,
                    fontSize: FontSize.md,
                  ),
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
          GestureDetector(
            onTap: () {
              showSimpleCustomDialog(context);
            },
            child: Row(
              children: <Widget>[
                Icon(Icons.add, color: blue, size: _screenWidth * 0.05),
                Padding(padding: EdgeInsets.only(right: _screenWidth * 0.02)),
                CustomText(
                  text: "Ajouter une image",
                  fontColor: FontColor.blue,
                  fontSize: FontSize.md,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

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
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  children: <Widget>[
                    buildTopContent(),
                    buildTitle(),
                    Padding(
                        padding: EdgeInsets.only(bottom: _screenHeight * 0.02)),
                    buildForm(),
                    Padding(
                        padding:
                            EdgeInsets.only(bottom: _screenHeight * 0.055)),
                    buildSubmitButton(),
                    Padding(
                        padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
