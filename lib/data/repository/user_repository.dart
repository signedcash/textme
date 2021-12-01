import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:textme/data/model/api_auth.dart';
import 'package:http/http.dart' as http;
import 'package:textme/data/model/api_user.dart';
import 'package:textme/domain/user_info.dart';

class UserRepository {
  static const _BASE_URL = 'http://10.0.2.2:8000/';

  final Dio _dio = Dio(
    BaseOptions(contentType: 'application/json'),
  );

  UserRepository();

  Future<http.StreamedResponse> getCurrentUser() async {
    var headers = {'Authorization': 'Bearer ' + currentSessionToken.token};
    var request = http.Request('GET', Uri.parse(_BASE_URL + 'api/users/'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> getById(int id) async {
    var headers = {'Authorization': 'Bearer ' + currentSessionToken.token};
    var request = http.Request(
        'GET', Uri.parse(_BASE_URL + 'api/users/' + id.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> getByUsername(String username) async {
    var headers = {'Authorization': 'Bearer ' + currentSessionToken.token};
    var request = http.Request(
        'GET', Uri.parse(_BASE_URL + 'api/users/search/' + username));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> update(ApiUser user) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(_BASE_URL + 'api/users/'));
    request.body = json.encode({"name": user.name, "img_url": user.imgUrl});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
