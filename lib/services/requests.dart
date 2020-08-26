import 'package:flutter/material.dart';
import 'package:polypeip/models/Post.dart';
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

Future getPost() async {}

Future addPost() async {}

Future ratePost() async {}

Future editPost() async {}

Future removePost() async {}

// EVENTS
Future getNextEvents() async {}

Future getPastEvents() async {}

Future getEvent() async {}

Future addEvent() async {}

Future editEvent() async {}

Future removeEvent() async {}

Future rateEvent() async {}

Future commentEvent() async {}

// MESSAGES
Future getMessages() async {}

Future getMessage() async {}

Future sendMessage() async {}

// INFOS
/* annuary */
Future getContacts() async {}

Future editContact() async {}

Future removeContact() async {}

/* social network */
Future getSocialNetworks() async {}

Future editSocialNetworks() async {}

Future removeSocialNetworks() async {}

/* links */
Future getLinks() async {}

Future editLink() async {}

Future removeLink() async {}

/* goodies */
Future getGoodies() async {}

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
