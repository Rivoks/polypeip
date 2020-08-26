import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:mime/mime.dart';

final apiKey = "061e411e417766bfc7b370d08d2fbd49";
final apiUrl = "http://127.0.0.1:3000/api";

enum RequestType { get, post, put, delete }

Future<Map<String, dynamic>> request(
  RequestType type,
  String route, {
  Map<String, dynamic> body,
  bool logout = false,
  bool stringify = false,
}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  http.Response response;
  var token = prefs.getString('token');

  print(token);
  if (body == null) body = {};
  if (stringify) {
    Map<String, dynamic> tmp = {};
    body.forEach((key, data) {
      tmp[key] = data.toString();
    });
    body = tmp;
  }
  var completeUrl = apiUrl + route;

  switch (type) {
    case RequestType.get:
      var options = '?';
      body.forEach((key, val) => options += key + '=' + val.toString() + '&');
      response = await http.get(
        Uri.encodeFull(completeUrl + options),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      break;
    case RequestType.post:
      response = await http.post(
        Uri.encodeFull(completeUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
        body: body,
      );
      break;
    case RequestType.put:
      response = await http.put(
        Uri.encodeFull(completeUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
        body: body,
      );
      break;
      break;
    case RequestType.delete:
      response = await http.delete(
        Uri.encodeFull(completeUrl),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'bearer $token',
        },
      );
      break;
  }
  if (response.statusCode == 401) prefs.remove('token');
  if (logout) {
    prefs.remove('token');
    return null;
  }
  return {'data': json.decode(response.body), 'status': response.statusCode};
}

Future<int> formDataRequest(String route,
    {Map<String, dynamic> body,
    List<Map<String, dynamic>> files,
    RequestType type = RequestType.post}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var token = prefs.getString('token');
  if (body == null) body = {};

  var completeUrl = apiUrl + route;

  final imageUploadRequest = http.MultipartRequest(
    type == RequestType.post ? 'POST' : 'PUT',
    Uri.parse(completeUrl),
  );

  files.forEach((f) async {
    if (f['isArray'] == true) {
      (f['imgs'] as List<File>).forEach((img) async {
        var mimeTypeData =
            lookupMimeType(img.path, headerBytes: [0xFF, 0xD8]).split('/');

        var file = await http.MultipartFile.fromPath(
          f['name'],
          img.path,
          contentType: MediaType(
            mimeTypeData[0],
            mimeTypeData[1],
          ),
        );
        imageUploadRequest.files.add(file);
      });
    } else {
      var img = (f['img'] as File);
      var mimeTypeData =
          lookupMimeType(img.path, headerBytes: [0xFF, 0xD8]).split('/');
      var file = await http.MultipartFile.fromPath(
        f['name'],
        img.path,
        contentType: MediaType(
          mimeTypeData[0],
          mimeTypeData[1],
        ),
      );
      imageUploadRequest.files.add(file);
    }
  });

  Map<String, String> tmp = {};
  body.forEach((key, val) => tmp[key] = jsonEncode(val));
  imageUploadRequest.fields.addAll(tmp);

  try {
    imageUploadRequest.headers.addAll({
      'Accept': 'application/json',
      'Authorization': 'bearer $token',
    });

    final streamedResponse = await imageUploadRequest.send();
    final response = await http.Response.fromStream(streamedResponse);

    return response.statusCode;
  } catch (e) {
    print(e);
    return 500;
  }
}
