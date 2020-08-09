// import 'package:device_preview/device_preview.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:polypeip/EventsPage.dart';
import 'package:polypeip/HomePage.dart';
import 'package:polypeip/InfoPage.dart';
import 'package:polypeip/LaunchPage.dart';
import 'package:polypeip/LoginPage.dart';
import 'package:polypeip/PostEventPage.dart';
import 'package:polypeip/PostEventPageOld.dart';
import 'package:polypeip/PostMessagePage.dart';
import 'package:polypeip/PostPage.dart';
import 'package:polypeip/SettingsPage.dart';
import 'package:polypeip/MessagePage.dart';
import 'package:polypeip/admin_pages/ActivitesAddPage.dart';
import 'package:polypeip/admin_pages/ActivitesEditPage.dart';
import 'package:polypeip/admin_pages/ActivitesPage.dart';
import 'package:polypeip/admin_pages/AnnuaireAddPage.dart';
import 'package:polypeip/admin_pages/AnnuaireEditPage.dart';
import 'package:polypeip/admin_pages/EventAddPage.dart';
import 'package:polypeip/admin_pages/EventEditPage.dart';
import 'package:polypeip/admin_pages/GoodiesAddPage.dart';
import 'package:polypeip/admin_pages/GoodiesEditPage.dart';
import 'package:polypeip/admin_pages/GoodiesPage.dart';
import 'package:polypeip/admin_pages/LinksAddPage.dart';
import 'package:polypeip/admin_pages/LinksEditPage.dart';
import 'package:polypeip/admin_pages/ListAnnuairePage.dart';
import 'package:polypeip/admin_pages/ListEventsPage.dart';
import 'package:polypeip/admin_pages/ListLinksPage.dart';
import 'package:polypeip/admin_pages/ListReseauxPage.dart';
import 'package:polypeip/admin_pages/MessageWritePage.dart';
import 'package:polypeip/admin_pages/MessageriePage.dart';
import 'package:polypeip/admin_pages/PlanEdtAddPage.dart';
import 'package:polypeip/admin_pages/PlanEdtEditPage.dart';
import 'package:polypeip/admin_pages/PlanEdtPage.dart';
import 'package:polypeip/admin_pages/PostMessageriePage.dart';
import 'package:polypeip/admin_pages/PostMessagerieReceviedPage.dart';
import 'package:polypeip/admin_pages/ReseauxAddPage.dart';
import 'package:polypeip/admin_pages/ReseauxEditPage.dart';
import 'package:polypeip/infoPages/InfoAnnuairePage.dart';
import 'package:polypeip/infoPages/InfoDancePage.dart';
import 'package:polypeip/infoPages/InfoEdtPage.dart';
import 'package:polypeip/infoPages/InfoGoodiesPage.dart';
import 'package:polypeip/infoPages/InfoIdeaPage.dart';
import 'package:polypeip/infoPages/InfoPlanPage.dart';

// void main() {
//   runApp(DevicePreview(
//     builder: (context) => MyApp(),
//   ));
// }
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Polypeip',
        // locale: DevicePreview.of(context)?.locale,
        // builder: DevicePreview.appBuilder,
        theme: ThemeData(
            primaryColor: Color(0xff00adef),
            primaryIconTheme: IconThemeData(color: Colors.white)),
        initialRoute: "/",
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case "/":
              return PageTransition(
                  child: LaunchPage(), type: PageTransitionType.fade);
              break;
            case "/home":
              return PageTransition(
                  child: HomePage(), type: PageTransitionType.fade);
              break;
            case "/events":
              return PageTransition(
                  child: EventsPage(), type: PageTransitionType.fade);
              break;
            case "/settings":
              return PageTransition(
                  child: SettingsPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/message":
              return PageTransition(
                  child: MessagePage(), type: PageTransitionType.fade);
              break;
            case "/info":
              return PageTransition(
                  child: InfoPage(), type: PageTransitionType.fade);
              break;
            case "/infoAnnuaire":
              return PageTransition(
                  child: InfoAnnuairePage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/infoPlan":
              return PageTransition(
                  child: InfoPlanPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/infoEdt":
              return PageTransition(
                  child: InfoEdtPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/infoIdea":
              return PageTransition(
                  child: InfoIdeaPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/infoGoodies":
              return PageTransition(
                  child: InfoGoodiesPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/infoDance":
              return PageTransition(
                  child: InfoDancePage(), type: PageTransitionType.rightToLeft);
              break;
            case "/login":
              return PageTransition(
                  child: LoginPage(), type: PageTransitionType.fade);
              break;
            case "/edit/activites":
              return PageTransition(
                  child: ActivitesPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/events":
              return PageTransition(
                  child: ListEventsPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/annuaire":
              return PageTransition(
                  child: ListAnnuairePage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/reseaux":
              return PageTransition(
                  child: ListReseauxPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/links":
              return PageTransition(
                  child: ListLinksPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/planEdt":
              return PageTransition(
                  child: PlanEdtPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/goodies":
              return PageTransition(
                  child: GoodiesPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/messagerie":
              return PageTransition(
                  child: MessageriePage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addActivite":
              return PageTransition(
                  child: ActivitesAddPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addEvent":
              return PageTransition(
                  child: EventAddPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addAnnuaire":
              return PageTransition(
                  child: AnnuaireAddPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addReseaux":
              return PageTransition(
                  child: ReseauxAddPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addLinks":
              return PageTransition(
                  child: LinksAddPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addPlanEdt":
              return PageTransition(
                  child: PlanEdtAddPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addGoodies":
              return PageTransition(
                  child: GoodiesAddPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editActivite':
              return PageTransition(
                  child: ActivitesEditPage(
                    activiteId: getParameters(settings.arguments, 'activiteId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editEvent':
              return PageTransition(
                  child: EventEditPage(
                    eventId: getParameters(settings.arguments, 'eventId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editAnnuaire':
              return PageTransition(
                  child: AnnuaireEditPage(
                    staffId: getParameters(settings.arguments, 'staffId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editReseaux':
              return PageTransition(
                  child: ReseauxEditPage(
                    reseauxId: getParameters(settings.arguments, 'reseauxId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editLinks':
              return PageTransition(
                  child: LinksEditPage(
                    linksId: getParameters(settings.arguments, 'linksId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editPlanEdt':
              return PageTransition(
                  child: PlanEdtEditPage(
                    planEdtId: getParameters(settings.arguments, 'planEdtId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editGoodies':
              return PageTransition(
                  child: GoodiesEditPage(
                    goodiesId: getParameters(settings.arguments, 'goodiesId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/post':
              return PageTransition(
                  child: PostPage(
                    postId: getParameters(settings.arguments, 'postId'),
                  ),
                  type: PageTransitionType.downToUp);
              break;
            case '/postMessage':
              return PageTransition(
                  child: PostMessagePage(
                    postId: getParameters(settings.arguments, 'postMessageId'),
                  ),
                  type: PageTransitionType.downToUp);
              break;
            case '/postEvent':
              return PageTransition(
                  child: PostEventPage(
                    postId: getParameters(settings.arguments, 'postEventId'),
                  ),
                  type: PageTransitionType.downToUp);
              break;
            case '/postEventOld':
              return PageTransition(
                  child: PostEventPageOld(
                    postId: getParameters(settings.arguments, 'postEventId'),
                  ),
                  type: PageTransitionType.downToUp);
              break;
            case '/admin/message':
              return PageTransition(
                  child: PostMessageriePage(
                    messageId: getParameters(settings.arguments, 'messageId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/admin/messageRecevied':
              return PageTransition(
                  child: PostMessagerieReceviedPage(
                    messageId: getParameters(settings.arguments, 'messageId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/admin/answerMessage':
              return PageTransition(
                  child: MessageWritePage(
                    messageId: getParameters(settings.arguments, 'messageId'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;

            default:
              return null;
          }
        },
      ),
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
    );
  }
}

dynamic getParameters(Object arguments, String name) {
  return json.decode(JsonEncoder().convert(arguments))[name];
}
