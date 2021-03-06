import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventEditPage extends StatefulWidget {
  EventEditPage({@required this.event});

  final Event event;

  @override
  _EventEditPageState createState() => _EventEditPageState();
}

class _EventEditPageState extends State<EventEditPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  TextEditingController nameTFC = TextEditingController();
  TextEditingController descriptionTFC = TextEditingController();
  DateTime date = DateTime.now();

  double _screenHeight;
  double _screenWidth;

  double spaceInput = 0.1;

  Color blue = CustomText.textColor(FontColor.blue);
  Color adminColor = Color(0xFF7f8fa6);

  @override
  void initState() {
    super.initState();

    nameTFC.text = widget.event.name;
    descriptionTFC.text = widget.event.description;
    date = widget.event.date;
  }

  Widget buildTopContent() {
    return Container(
        height: _screenHeight * 0.154,
        width: _screenWidth,
        color: adminColor,
        child: Column(
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
              text: "modifier un évènement",
              fontColor: FontColor.white,
              fontSize: FontSize.lg,
              uppercase: true,
              fontWeight: FontWeight.bold,
            )
          ],
        ));
  }

  Widget buildTitle() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: _screenWidth * 0.08, vertical: _screenHeight * 0.04),
      child: CustomText(
        text: "Remplissez les champs pour modifier un évènement",
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
        onPressed: () => editEvent(
          widget.event.id,
          nameTFC.text,
          descriptionTFC.text,
          context: context,
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
              hintText: "Titre de l'évènement",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.04)),
          GestureDetector(
            onTap: () {
              // DatePicker.showDatePicker(context,
              //     showTitleActions: true,
              //     minTime: DateTime.now(),
              //     maxTime: DateTime(2050, 12, 31), onChanged: (date) {
              //   print('change $date');
              // }, onConfirm: (date) {
              //   print('confirm $date');
              // }, currentTime: DateTime.now(), locale: LocaleType.fr);
              print("test");
            },
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: _screenHeight * 0.05),
                    padding: EdgeInsets.only(bottom: _screenHeight * 0.01),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[500],
                          width: 1,
                        ),
                      ),
                    ),
                    child: CustomText(
                      text: "Date de l'évènement : ",
                      fontColor: FontColor.grey,
                      fontSize: FontSize.md,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.centerRight,
                      child: CustomText(
                        text: "____ / ____ / _______",
                        fontColor: FontColor.grey,
                        fontSize: FontSize.md,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.01)),
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
              hintText: "Description de l'event",
              hintStyle: TextStyle(
                fontStyle: FontStyle.italic,
                color: Colors.grey[500],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              // DatePicker.showTimePicker(
              //   context,
              //   showTitleActions: true,
              //   locale: LocaleType.fr,
              //   showSecondsColumn: false,
              // );
              print("test");
            },
            child: Container(
              alignment: Alignment.centerLeft,
              child: Row(
                children: <Widget>[
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: _screenHeight * 0.05),
                    padding: EdgeInsets.only(bottom: _screenHeight * 0.01),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey[500],
                          width: 1,
                        ),
                      ),
                    ),
                    child: CustomText(
                      text: "Heure de l'évènement : ",
                      fontColor: FontColor.grey,
                      fontSize: FontSize.md,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin:
                          EdgeInsets.symmetric(vertical: _screenHeight * 0.05),
                      child: CustomText(
                        text: "____ : ____",
                        fontColor: FontColor.grey,
                        fontSize: FontSize.md,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: _screenHeight * 0.05)),
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
