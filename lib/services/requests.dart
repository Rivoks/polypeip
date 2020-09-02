import 'dart:io';
import 'package:flutter/material.dart';
import 'package:polypeip/models/Contact.dart';
import 'package:polypeip/models/Event.dart';
import 'package:polypeip/models/Goodie.dart';
import 'package:polypeip/models/Message.dart';
import 'package:polypeip/models/Post.dart';
import 'package:polypeip/models/SocialNetwork.dart';
import 'request.dart';

// ERRORS
void error401(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Vous devez vous connecter pour continuer"),
      content: Text("Nous allons vous rediriger vers la page de connexion."),
      actions: [
        FlatButton(
          child: Text("Me connecter"),
          onPressed: () => Navigator.pushNamedAndRemoveUntil(
              context, "/login", (route) => false),
        )
      ],
    ),
    barrierDismissible: false,
  );
}

void error404(BuildContext context) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      title: Text("Erreur 404 !"),
      content: Text(
          "Désolé nous ne trouvons pas cette page, il se pourrait qu'elle ai été supprimée"),
      actions: [
        FlatButton(
          child: Text("Ok"),
          onPressed: () => Navigator.pop(context),
        )
      ],
    ),
    barrierDismissible: false,
  );
}

// POSTS
Future<List<Post>> getPosts({context: BuildContext}) async {
  List<Post> posts;

  await request(RequestType.get, '/posts/').then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return [];
          break;
        case 404:
          error404(context);
          return [];
        default:
          return [];
      }
    }

    print(res['data']['posts']);
    posts = (res['data']['posts'] as List<dynamic>)
        .map((post) => Post.fromJson(post))
        .toList();
  });

  return posts;
}

Future<Post> getPost(String id, {context: BuildContext}) async {
  Post post;

  await request(RequestType.get, '/posts/' + id).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return null;
          break;
        case 404:
          error404(context);
          return null;
        default:
          return null;
      }
    }
    post = Post.fromJson(res['data']['post'] as dynamic);
  });

  return post;
}

Future addPost(String name, String content, File img,
    {context: BuildContext}) async {
  var res = await request(RequestType.post, '/posts/', body: {
    "name": name,
    "content": content,
  });
  if (res["status"] != 200) {
    switch (res["status"]) {
      case 401:
        error401(context);
        break;
      case 404:
        error404(context);
        break;
      default:
        return;
    }
  }
}

Future reactPost(String id, String action, {context: BuildContext}) async {
  await request(
    RequestType.post,
    '/posts/' + action + '/' + id,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

Future editPost(String id, String name, String content, File img,
    {context: BuildContext}) async {
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
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

Future removePost(String id, {context: BuildContext}) async {
  await request(
    RequestType.delete,
    '/posts/' + id,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

// EVENTS
Future<List<Event>> getEvents({context: BuildContext}) async {
  List<Event> events;

  await request(RequestType.get, '/event/').then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return [];
          break;
        case 404:
          error404(context);
          return [];
          break;
        default:
          return [];
      }
    }
    events = (res['data']['events'] as List<dynamic>)
        .map((post) => Event.fromJson(post))
        .toList();
  });

  return events;
}

Future<Event> getEvent(String id, bool isOld, {context: BuildContext}) async {
  Event event;

  await request(RequestType.get, '/event/' + id).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return null;
          break;
        case 404:
          error404(context);
          return null;
          break;
        default:
          return null;
      }
    }
    event = Event.fromJson(res['data']['event'] as dynamic);
  });

  return event;
}

Future addEvent(String name, String description,
    {context: BuildContext}) async {
  await request(RequestType.post, '/event/', body: {
    "name": name,
    "description": description,
  }).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
  });
}

Future editEvent(String id, String name, String description,
    {context: BuildContext}) async {
  Map<String, dynamic> body = {
    "name": name,
    "description": description,
  };

  await request(
    RequestType.put,
    '/event/' + id,
    body: body,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

Future removeEvent(String id, {context: BuildContext}) async {
  await request(
    RequestType.delete,
    '/event/' + id,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

// TODO
Future rateEvent({context: BuildContext}) async {}

// TODO
Future commentEvent({context: BuildContext}) async {}

// MESSAGES
Future<List<Message>> getMessages({context: BuildContext}) async {
  List<Message> messages;

  await request(RequestType.get, '/message/').then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return [];
          break;
        case 404:
          error404(context);
          return [];
          break;
        default:
          return [];
      }
    }
    messages = (res['data']['messages'] as List<dynamic>)
        .map((post) => Message.fromJson(post))
        .toList();
  });

  return messages;
}

// TODO
Future sendMessage({context: BuildContext}) async {}

// INFOS
/* annuary */
Future addContact(String name, String surname, String email, String tel,
    {context: BuildContext}) async {
  await request(RequestType.post, '/contact/', body: {
    "name": name,
    "surname": surname,
    "email": email,
    "tel": tel,
  }).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
  });
}

Future<List<Contact>> getContacts({context: BuildContext}) async {
  List<Contact> contacts;

  await request(RequestType.get, '/contact/').then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return [];
          break;
        case 404:
          error404(context);
          return [];
          break;
        default:
          return [];
      }
    }
    print(res);
    contacts = (res['data']['contacts'] as List<dynamic>)
        .map((post) => Contact.fromJson(post))
        .toList();
  });

  return contacts;
}

Future editContact(
    String id, String name, String surname, String email, String tel,
    {context: BuildContext}) async {
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
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

Future removeContact(String id, {context: BuildContext}) async {
  await request(
    RequestType.delete,
    '/contact/' + id,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

/* social network */
Future<List<SocialNetwork>> getSocialNetworks({context: BuildContext}) async {
  List<SocialNetwork> socialNetworks;

  await request(RequestType.get, '/social/').then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return [];
          break;
        case 404:
          error404(context);
          return [];
          break;
        default:
          return [];
      }
    }
    socialNetworks = (res['data']['socials'] as List<dynamic>)
        .map((post) => SocialNetwork.fromJson(post))
        .toList();
  });

  return socialNetworks;
}

Future addSocialNetwork(String socialNetwork, String username, String url,
    {context: BuildContext}) async {
  await request(RequestType.post, '/social/', body: {
    "socialNetwork": socialNetwork,
    "username": username,
    "url": url,
  }).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
  });
}

Future editSocialNetworks(
    String id, String socialNetwork, String username, String url,
    {context: BuildContext}) async {
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
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

Future removeSocialNetworks(String id, {context: BuildContext}) async {
  await request(
    RequestType.delete,
    '/social/' + id,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

/* goodies */
Future<List<Goodie>> getGoodies({context: BuildContext}) async {
  List<Goodie> goodies;

  await request(RequestType.get, '/goodie/').then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          return [];
          break;
        case 404:
          error404(context);
          return [];
          break;
        default:
          return [];
      }
    }
    goodies = (res['data']['goodies'] as List<dynamic>)
        .map((post) => Goodie.fromJson(post))
        .toList();
  });

  return goodies;
}

Future addGoodie(String name, String description, String price, File img,
    {context: BuildContext}) async {
  var res = await request(RequestType.post, '/goodie', body: {
    "name": name,
    "description": description,
    "price": price,
  });

  if (res["status"] != 200) {
    switch (res["status"]) {
      case 401:
        error401(context);
        break;
      case 404:
        error404(context);
        break;
      default:
        return;
    }
  }

  print(res);
}

Future editGoodie(
    String id, String name, String description, String price, File img,
    {context: BuildContext}) async {
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
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

Future removeGoodie(String id, {context: BuildContext}) async {
  await request(
    RequestType.delete,
    '/goodie/' + id,
  ).then((res) {
    if (res["status"] != 200) {
      switch (res["status"]) {
        case 401:
          error401(context);
          break;
        case 404:
          error404(context);
          break;
        default:
          return;
      }
    }
    print(res);
  });
}

/* plan & edt */
// TODO
Future editPlan({context: BuildContext}) async {}

// TODO
Future addEdt({context: BuildContext}) async {}

// TODO
Future editEdt({context: BuildContext}) async {}

// TODO
Future removeEdt({context: BuildContext}) async {}

// SETTINGS
// TODO
Future getNotificationStatus({context: BuildContext}) async {}

// TODO
Future setNotificationStatus({context: BuildContext}) async {}

// TODO
Future getSupport({context: BuildContext}) async {}

// TODO
Future getAppVersion({context: BuildContext}) async {}
