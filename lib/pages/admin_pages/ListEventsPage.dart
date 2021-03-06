import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomBackAppBar.dart';
import 'package:polypeip/custom_widgets/CustomRoundedButton.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/pages/PostEventPage.dart';
import 'package:polypeip/pages/admin_pages/EventEditPage.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ListEventsPage extends StatefulWidget {
  @override
  _ListEventsPageState createState() => _ListEventsPageState();
}

class _ListEventsPageState extends State<ListEventsPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  List<Event> events;

  void setPage() {
    getEvents(context: context).then((value) {
      setState(() => events = value);
    });
  }

  @override
  void initState() {
    super.initState();
    setPage();
  }

  Color adminColor = Color(0xFF7f8fa6);

  Widget buildEditForm(height, width, index) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        PageTransition(
          child: PostEventPage(eventId: events[index].id),
          type: PageTransitionType.downToUp,
        ),
      ).then((value) => setPage()),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: width * 0.05),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          height: height * 0.13,
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
              Container(
                width: width * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CustomText(
                      text: events[index].name,
                      fontColor: FontColor.black,
                      fontSize: FontSize.md,
                      fontWeight: FontWeight.bold,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: height * 0.015)),
                    CustomText(
                      text: events[index].date.toIso8601String(),
                      fontColor: FontColor.black,
                      fontSize: FontSize.sm,
                      fontWeight: FontWeight.w400,
                    ),
                    CustomText(
                      text: events[index].date.hour.toString(),
                      fontColor: FontColor.black,
                      fontSize: FontSize.xs,
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
                      onTap: () => Navigator.push(
                        context,
                        PageTransition(
                          child: EventEditPage(
                            event: events[index],
                          ),
                          type: PageTransitionType.downToUp,
                        ),
                      ).then((value) => setPage()),
                    ),
                    Padding(padding: EdgeInsets.only(right: width * 0.05)),
                    GestureDetector(
                      child: Icon(Icons.delete, color: Colors.grey[800]),
                      onTap: () => removeEvent(
                        events[index].id,
                        context: context,
                      ).then(
                        (value) => setState(
                          () => events.removeAt(index),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
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
        text: "Ajouter un évènement",
        fontColor: FontColor.blue,
        fontSize: FontSize.md,
        fontWeight: FontWeight.bold,
        backgroundColor: null,
        borderColor: CustomText.textColor(FontColor.blue),
        onPressed: () => Navigator.pushNamed(context, "/edit/addEvent")
            .then((value) => setPage()),
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
              text: "gérer les évènements",
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
            itemCount: events != null ? events.length : 0,
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
                  (index == (events != null ? events.length - 1 : 0))
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
