import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:polypeip/custom_icons/font_awesome_icons.dart';
import 'package:polypeip/custom_widgets/CustomAppBar.dart';
import 'package:polypeip/custom_widgets/CustomBottomBar.dart';
import 'package:polypeip/custom_widgets/CustomText.dart';
import 'package:polypeip/custom_widgets/CustomTopbarAlt.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/services/requests.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EventsPage extends StatefulWidget {
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  double _screenHeight;
  double _screenWidth;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  List<Event> oldEvents = [];
  List<Event> newEvents = [];
  List<Map<String, String>> lEvents = [
    {
      "_id": "618ze9f4zfze496",
      "title": "Soirée Cave Esclangon",
      "date": "04/05/2020",
      "hour": "18h00",
      "rate": "4.5",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec neque sapien. Proin suscipit commodo tellus, efficitur finibus nulla sollicitudin sagittis. Duis neque turpis, euismod vel porta non, varius pretium diam. Etiam non posuere justo. Vestibulum nec enim non tortor finibus pulvinar a ac ex. Mauris tempor, risus non accumsan egestas, felis erat lacinia neque, sed ornare mi ligula a erat. Praesent et augue consequat felis feugiat tincidunt. Nam libero urna, faucibus nec justo quis, convallis condimentum orci. Morbi nulla justo, venenatis et augue vel, ornare dapibus sapien. Nulla sed sodales felis. Etiam dictum sapien id lacus sagittis consequat. "
    },
    {
      "_id": "618ze9f4zfze496",
      "title": "Quais St Bernard",
      "date": "11/05/2020",
      "hour": "18h00",
      "rate": "3",
      "description":
          "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc nec neque sapien. Proin suscipit commodo tellus, efficitur finibus nulla sollicitudin sagittis. Duis neque turpis, euismod vel porta non, varius pretium diam. Etiam non posuere justo. Vestibulum nec enim non tortor finibus pulvinar a ac ex. Mauris tempor, risus non accumsan egestas, felis erat lacinia neque, sed ornare mi ligula a erat. Praesent et augue consequat felis feugiat tincidunt. Nam libero urna, faucibus nec justo quis, convallis condimentum orci. Morbi nulla justo, venenatis et augue vel, ornare dapibus sapien. Nulla sed sodales felis. Etiam dictum sapien id lacus sagittis consequat. "
    },
  ];

  String listChoice = "new";
  CarouselController buttonCarouselController = CarouselController();

  final double topBarHeightPercent = 0.06;

  @override
  void initState() {
    super.initState();
    getEvents(context: context).then((events) {
      if (events == null) return;
      events.forEach((event) {
        setState(() {
          if (!event.date.isBefore(DateTime.now()))
            oldEvents.add(event);
          else
            newEvents.add(event);
        });
      });
    });
  }

  Widget buildTopContent() {
    return Container(
      width: _screenWidth,
      color: CustomText.textColor(FontColor.blue),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _screenHeight * 0.02),
        child: Column(
          children: <Widget>[
            Icon(
              FontAwesome.calendar,
              size: _screenHeight * 0.07,
              color: CustomText.textColor(FontColor.white),
            ),
            Padding(padding: EdgeInsets.only(top: _screenHeight * 0.01)),
            CustomText(
              text: "Les évènements Polypeip",
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
              listChoice = "new";
            else
              listChoice = "old";
          });
        },
      ),
      items: [
        ListView.builder(
            itemCount: newEvents.length == 0 ? 1 : newEvents.length,
            itemBuilder: (context, index) {
              if (newEvents.length == 0) return Text("Pas d'events à venir");

              Event event = newEvents[index];
              return buildevents(event);
            }),
        ListView.builder(
            itemCount: oldEvents.length == 0 ? 1 : oldEvents.length,
            itemBuilder: (context, index) {
              if (oldEvents.length == 0) return Text("Pas d'events passés");

              Event event = oldEvents[index];
              return buildevents(event);
            }),
      ],
    );
  }

  Widget constructTopBar() {
    double topBarHeight = _screenHeight * topBarHeightPercent;

    return CustomTopbarAlt(
      context: context,
      widthScreen: _screenWidth,
      heightScreen: _screenHeight,
      appBarHeight: topBarHeightPercent,
      topBarChild: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          new GestureDetector(
            onTap: () {
              if (listChoice != "new") {
                buttonCarouselController.previousPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
                setState(() {
                  listChoice = "new";
                });
              }
            },
            child: new Container(
              alignment: Alignment.center,
              color: Colors.white,
              width: _screenWidth / 2,
              padding: EdgeInsets.only(left: _screenWidth / 8),
              height: topBarHeight,
              child: CustomText(
                text: "En approche",
                fontColor:
                    (listChoice == 'old') ? FontColor.grey : FontColor.blue,
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          new GestureDetector(
            onTap: () {
              if (listChoice != "old") {
                buttonCarouselController.nextPage(
                  duration: Duration(milliseconds: 500),
                  curve: Curves.linear,
                );
                setState(() {
                  listChoice = "old";
                });
              }
            },
            child: new Container(
              color: Colors.white,
              width: _screenWidth / 2,
              height: topBarHeight,
              padding: EdgeInsets.only(right: _screenWidth / 8),
              alignment: Alignment.center,
              child: CustomText(
                text: "Terminés",
                fontColor:
                    (listChoice == 'new') ? FontColor.grey : FontColor.blue,
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildevents(Event event) {
    return GestureDetector(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border(
              bottom: BorderSide(color: Colors.grey[350], width: 0.5),
            )),
        width: _screenWidth,
        padding: EdgeInsets.symmetric(
          horizontal: 0.05 * _screenWidth,
          vertical: 0.025 * _screenHeight,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              FontAwesome.calendar,
              color: CustomText.textColor(FontColor.darkGrey),
              size: _screenHeight * 0.05,
            ),
            Padding(padding: EdgeInsets.only(right: _screenWidth * 0.025)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomText(
                  text: event.name,
                  fontColor: FontColor.blue,
                  fontSize: FontSize.md,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  text: event.date.toIso8601String() +
                      ' à ' +
                      event.date.hour.toString(),
                  fontColor: FontColor.darkGrey,
                  fontSize: FontSize.xs,
                  fontWeight: FontWeight.normal,
                ),
              ],
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  CustomText(
                    text: event.nbTotalRate == 0
                        ? "0"
                        : (event.totalRate / event.nbTotalRate).toString() +
                            '/5',
                    fontColor: FontColor.blue,
                    fontSize: FontSize.md,
                    fontWeight: FontWeight.w700,
                  ),
                  Padding(
                      padding: EdgeInsets.only(right: _screenWidth * 0.015)),
                  Icon(
                    FontAwesome.star,
                    size: _screenHeight * 0.028,
                    color: CustomText.textColor(FontColor.blue),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        if (listChoice == 'new') {
          return Navigator.pushNamed(context, "/postEvent",
              arguments: {"eventId": event.id, "isPassed": false});
        } else {
          return Navigator.pushNamed(context, "/postEventOld",
              arguments: {"eventId": event.id, "isPassed": true});
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _screenWidth = MediaQuery.of(context).size.width;

    return Container(
      color: CustomText.textColor(FontColor.lightBlue),
      child: SafeArea(
        child: Scaffold(
          appBar: CustomAppBar(
              context: this.context,
              heightScreen: _screenHeight,
              widthScreen: _screenWidth),
          body: SmartRefresher(
            controller: RefreshController(initialRefresh: false),
            enablePullUp: true,
            header: WaterDropMaterialHeader(),
            onRefresh: () async {
              await Future.delayed(Duration(milliseconds: 1000));
              _refreshController.refreshCompleted();
            },
            onLoading: () async {
              print("loading");
            },
            child: ListView.builder(
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: <Widget>[
                    (index == 0) ? buildTopContent() : Container(),
                    (index == 0) ? constructTopBar() : Container(),
                    buildSlider(_screenHeight, _screenWidth)
                  ],
                );
              },
            ),
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
