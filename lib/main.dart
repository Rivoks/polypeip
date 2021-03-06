import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:polypeip/pages/EventsPage.dart';
import 'package:polypeip/pages/HomePage.dart';
import 'package:polypeip/pages/InfoPage.dart';
import 'package:polypeip/pages/LaunchPage.dart';
import 'package:polypeip/pages/LoginPage.dart';
import 'package:polypeip/pages/PostEventPage.dart';
import 'package:polypeip/pages/PostEventPageOld.dart';
import 'package:polypeip/pages/PostMessagePage.dart';
import 'package:polypeip/pages/PostPage.dart';
import 'package:polypeip/pages/SettingsPage.dart';
import 'package:polypeip/pages/MessagePage.dart';
import 'package:polypeip/pages/SigninPage.dart';
import 'package:polypeip/pages/admin_pages/ActivitesAddPage.dart';
import 'package:polypeip/pages/admin_pages/ActivitesEditPage.dart';
import 'package:polypeip/pages/admin_pages/ActivitesPage.dart';
import 'package:polypeip/pages/admin_pages/AnnuaireAddPage.dart';
import 'package:polypeip/pages/admin_pages/AnnuaireEditPage.dart';
import 'package:polypeip/pages/admin_pages/EventAddPage.dart';
import 'package:polypeip/pages/admin_pages/EventEditPage.dart';
import 'package:polypeip/pages/admin_pages/GoodiesAddPage.dart';
import 'package:polypeip/pages/admin_pages/GoodiesEditPage.dart';
import 'package:polypeip/pages/admin_pages/GoodiesPage.dart';
import 'package:polypeip/pages/admin_pages/ListAnnuairePage.dart';
import 'package:polypeip/pages/admin_pages/ListEventsPage.dart';
import 'package:polypeip/pages/admin_pages/ListReseauxPage.dart';
import 'package:polypeip/pages/admin_pages/MessageWritePage.dart';
import 'package:polypeip/pages/admin_pages/MessageriePage.dart';
import 'package:polypeip/pages/admin_pages/PlanEditPage.dart';
import 'package:polypeip/pages/admin_pages/EdtAddPage.dart';
import 'package:polypeip/pages/admin_pages/EdtEditPage.dart';
import 'package:polypeip/pages/admin_pages/PlanEdtPage.dart';
import 'package:polypeip/pages/admin_pages/PostMessageriePage.dart';
import 'package:polypeip/pages/admin_pages/PostMessagerieReceviedPage.dart';
import 'package:polypeip/pages/admin_pages/ReseauxAddPage.dart';
import 'package:polypeip/pages/admin_pages/ReseauxEditPage.dart';
import 'package:polypeip/pages/infoPages/InfoAnnuairePage.dart';
import 'package:polypeip/pages/infoPages/InfoDancePage.dart';
import 'package:polypeip/pages/infoPages/InfoEdtPage.dart';
import 'package:polypeip/pages/infoPages/InfoGoodiesPage.dart';
import 'package:polypeip/pages/infoPages/InfoIdeaPage.dart';
import 'package:polypeip/pages/infoPages/InfoPlanPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Polypeip',
        theme: ThemeData(
          primaryColor: Color(0xff00adef),
          primaryIconTheme: IconThemeData(color: Colors.white),
        ),
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
            case "/signin":
              return PageTransition(
                  child: SigninPage(), type: PageTransitionType.fade);
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
            case "/edit/addPlanEdt":
              return PageTransition(
                  child: EdtAddPage(), type: PageTransitionType.rightToLeft);
              break;
            case "/edit/addGoodies":
              return PageTransition(
                  child: GoodiesAddPage(),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editActivite':
              return PageTransition(
                  child: ActivitesEditPage(
                    post: getParameters(settings.arguments, 'post'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editEvent':
              return PageTransition(
                  child: EventEditPage(
                    event: getParameters(settings.arguments, 'event'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editAnnuaire':
              return PageTransition(
                  child: AnnuaireEditPage(
                    contact: getParameters(settings.arguments, 'contact'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editReseaux':
              return PageTransition(
                  child: ReseauxEditPage(
                    socialNetwork:
                        getParameters(settings.arguments, 'socialNetwork'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editPlan':
              return PageTransition(
                child: PlanEditPage(),
                type: PageTransitionType.rightToLeft,
              );
              break;
            case '/edit/editEdt':
              return PageTransition(
                  child: EdtEditPage(
                    planEdtId: getParameters(settings.arguments, 'planEdtId'),
                    initialName:
                        getParameters(settings.arguments, 'initialName'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/edit/editGoodies':
              return PageTransition(
                  child: GoodiesEditPage(
                    goodie: getParameters(settings.arguments, 'goodie'),
                  ),
                  type: PageTransitionType.rightToLeft);
              break;
            case '/post':
              return PageTransition(
                  child: PostPage(
                    post: getParameters(settings.arguments, 'post'),
                  ),
                  type: PageTransitionType.downToUp);
              break;
            case '/postMessage':
              return PageTransition(
                child: PostMessagePage(
                  message: getParameters(settings.arguments, 'message'),
                ),
                type: PageTransitionType.downToUp,
              );
              break;
            case '/postEvent':
              return PageTransition(
                  child: PostEventPage(
                    eventId: getParameters(settings.arguments, 'eventId'),
                  ),
                  type: PageTransitionType.downToUp);
              break;
            case '/postEventOld':
              return PageTransition(
                  child: PostEventPageOld(
                    eventId: getParameters(settings.arguments, 'eventId'),
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
