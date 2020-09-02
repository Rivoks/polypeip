import 'dart:io';
import 'package:polypeip/models/Contact.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/models/Goodie.dart';
import 'package:polypeip/models/Message.dart';
import 'package:polypeip/models/Post.dart';
import 'package:polypeip/models/SocialNetwork.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'request.dart';

// POSTS
Future<List<Post>> getPosts() async {
  List<Post> posts;

  await request(RequestType.get, '/posts/').then((res) {
    print(res['data']['posts']);
    posts = (res['data']['posts'] as List<dynamic>)
        .map((post) => Post.fromJson(post))
        .toList();
  });

  return posts;
}

Future<List<Post>> getPoststmp() async {
  List<Map<String, dynamic>> postsTmp = [
    {
      "clé": "valeur",
    }
  ];

  List<Post> posts = [];

  posts = postsTmp.map((e) => Post()).toList();
  return posts;
}

Future<Post> getPost(String id) async {
  Post post;

  await request(RequestType.get, '/posts/' + id).then((res) {
    post = Post.fromJson(res['data']['post'] as dynamic);
  });

  return post;
}

Future addPost(
  String name,
  String content,
  File img,
) async {
  await request(RequestType.post, '/posts/', body: {
    "name": name,
    "content": content,
  });
}

// TODO
Future reactPost(String id, String action) async {
  await request(
    RequestType.post,
    '/posts/' + action + '/' + id,
  ).then((res) {
    print(res);
  });
}

Future editPost(
  String id,
  String name,
  String content,
  File img,
) async {
  Map<String, dynamic> body = {
    "name": name,
    "content": content,
  };
  if (img != null) {
    body["img"] = img;
  }

  await request(
    RequestType.put,
    '/posts/' + id,
    body: body,
  ).then((res) {
    print(res);
  });
}

Future removePost(String id) async {
  await request(
    RequestType.delete,
    '/posts/' + id,
  ).then((res) {
    print(res);
  });
}

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

Future addEvent(
  String name,
  String description,
) async {
  await request(RequestType.post, '/event/', body: {
    "name": name,
    "description": description,
  });
}

Future editEvent(
  String id,
  String name,
  String description,
) async {
  Map<String, dynamic> body = {
    "name": name,
    "description": description,
  };

  await request(
    RequestType.put,
    '/event/' + id,
    body: body,
  ).then((res) {
    print(res);
  });
}

Future removeEvent(String id) async {
  await request(
    RequestType.delete,
    '/event/' + id,
  ).then((res) {
    print(res);
  });
}

// TODO
Future rateEvent() async {}

// TODO
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

// TODO
Future sendMessage() async {}

// INFOS
/* annuary */
Future addContact(
  String name,
  String surname,
  String email,
  String tel,
) async {
  await request(RequestType.post, '/contact/', body: {
    "name": name,
    "surname": surname,
    "email": email,
    "tel": tel,
  });
}

Future<List<Contact>> getContacts() async {
  List<Contact> contacts;

  await request(RequestType.get, '/contact/').then((res) {
    print(res);
    contacts = (res['data']['contacts'] as List<dynamic>)
        .map((post) => Contact.fromJson(post))
        .toList();
  });

  return contacts;
}

Future editContact(
  String id,
  String name,
  String surname,
  String email,
  String tel,
) async {
  Map<String, dynamic> body = {
    "name": name,
    "surname": surname,
    "email": email,
    "tel": tel,
  };

  await request(
    RequestType.put,
    '/contact/' + id,
    body: body,
  ).then((res) {
    print(res);
  });
}

Future removeContact(String id) async {
  await request(
    RequestType.delete,
    '/contact/' + id,
  ).then((res) {
    print(res);
  });
}

/* social network */
Future<List<SocialNetwork>> getSocialNetworks() async {
  List<SocialNetwork> socialNetworks;

  await request(RequestType.get, '/social/').then((res) {
    socialNetworks = (res['data']['socials'] as List<dynamic>)
        .map((post) => SocialNetwork.fromJson(post))
        .toList();
  });

  return socialNetworks;
}

Future addSocialNetwork(
  String socialNetwork,
  String username,
  String url,
) async {
  await request(RequestType.post, '/social/', body: {
    "socialNetwork": socialNetwork,
    "username": username,
    "url": url,
  });
}

Future editSocialNetworks(
  String id,
  String socialNetwork,
  String username,
  String url,
) async {
  Map<String, dynamic> body = {
    "socialNetwork": socialNetwork,
    "username": username,
    "url": url,
  };

  await request(
    RequestType.put,
    '/social/' + id,
    body: body,
  ).then((res) {
    print(res);
  });
}

Future removeSocialNetworks(String id) async {
  await request(
    RequestType.delete,
    '/social/' + id,
  ).then((res) {
    print(res);
  });
}

/* goodies */
Future<List<Goodie>> getGoodies() async {
  List<Goodie> goodies;

  await request(RequestType.get, '/goodie/').then((res) {
    goodies = (res['data']['goodies'] as List<dynamic>)
        .map((post) => Goodie.fromJson(post))
        .toList();
  });

  return goodies;
}

Future addGoodie(
  String name,
  String description,
  String price,
  File img,
) async {
  var tmp = await request(RequestType.post, '/goodie', body: {
    "name": name,
    "description": description,
    "price": price,
  });
  print(tmp);
}

Future editGoodie(
  String id,
  String name,
  String description,
  String price,
  File img,
) async {
  Map<String, dynamic> body = {
    "name": name,
    "description": description,
    "price": price,
  };

  await request(
    RequestType.put,
    '/goodie/' + id,
    body: body,
  ).then((res) {
    print(res);
  });
}

Future removeGoodie(String id) async {
  await request(
    RequestType.delete,
    '/goodie/' + id,
  ).then((res) {
    print(res);
  });
}

/* plan & edt */
// TODO
Future editPlan() async {}

// TODO
Future addEdt() async {}

// TODO
Future editEdt() async {}

// TODO
Future removeEdt() async {}

// SETTINGS
// TODO
Future getNotificationStatus() async {}

// TODO
Future setNotificationStatus() async {}

// TODO
Future getSupport() async {}

// TODO
Future getAppVersion() async {}
