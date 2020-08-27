import 'package:polypeip/models/Contact.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/models/Goodie.dart';
import 'package:polypeip/models/Message.dart';
import 'package:polypeip/models/Post.dart';
import 'package:polypeip/models/SocialNetwork.dart';
import 'request.dart';

// POSTS
Future<List<Post>> getPosts() async {
  List<Post> posts;

  await request(RequestType.get, '/posts/').then((res) {
    posts = (res['data']['posts'] as List<dynamic>)
        .map((post) => Post.fromJson(post))
        .toList();
  });

  return posts;
}

Future<Post> getPost(String id) async {
  Post post;

  await request(RequestType.get, '/posts/' + id).then((res) {
    post = Post.fromJson(res['data']['post'] as dynamic);
  });

  return post;
}

Future addPost() async {}

Future ratePost() async {}

Future editPost() async {}

Future removePost() async {}

// EVENTS
Future<List<Event>> getEvents() async {
  List<Event> events;

  await request(RequestType.get, '/event/').then((res) {
    events = (res['data']['events'] as List<dynamic>)
        .map((post) => Event.fromJson(post))
        .toList();
  });

  return events;
}

Future<Event> getEvent(String id, bool isOld) async {
  Event event;

  await request(RequestType.get, '/event/' + id).then((res) {
    event = Event.fromJson(res['data']['event'] as dynamic);
  });

  return event;
}

Future addEvent() async {}

Future editEvent() async {}

Future removeEvent() async {}

Future rateEvent() async {}

Future commentEvent() async {}

// MESSAGES
Future<List<Message>> getMessages() async {
  List<Message> messages;

  await request(RequestType.get, '/message/').then((res) {
    messages = (res['data']['messages'] as List<dynamic>)
        .map((post) => Message.fromJson(post))
        .toList();
  });

  return messages;
}

Future sendMessage() async {}

// INFOS
/* annuary */
Future getContacts() async {
  List<Contact> contacts;

  await request(RequestType.get, '/contact/').then((res) {
    print(res);
    contacts = (res['data']['contacts'] as List<dynamic>)
        .map((post) => Contact.fromJson(post))
        .toList();
  });

  return contacts;
}

Future editContact() async {}

Future removeContact() async {}

/* social network */
Future getSocialNetworks() async {
  List<SocialNetwork> socialNetworks;

  await request(RequestType.get, '/social/').then((res) {
    socialNetworks = (res['data']['socials'] as List<dynamic>)
        .map((post) => SocialNetwork.fromJson(post))
        .toList();
  });

  return socialNetworks;
}

Future editSocialNetworks() async {}

Future removeSocialNetworks() async {}

/* links */
Future getLinks() async {}

Future editLink() async {}

Future removeLink() async {}

/* goodies */
Future getGoodies() async {
  List<Goodie> goodies;

  await request(RequestType.get, '/goodie/').then((res) {
    goodies = (res['data']['goodies'] as List<dynamic>)
        .map((post) => Goodie.fromJson(post))
        .toList();
  });

  return goodies;
}

Future addGoodie() async {}

Future editGoodie() async {}

Future removeGoodie() async {}

/* plan & edt */
Future editPlan() async {}

Future addEdt() async {}

Future editEdt() async {}

Future removeEdt() async {}

// SETTINGS
Future getNotificationStatus() async {}

Future setNotificationStatus() async {}

Future getSupport() async {}

Future getAppVersion() async {}
