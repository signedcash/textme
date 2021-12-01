import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:textme/data/model/api_auth.dart';
import 'package:http/http.dart' as http;
import 'package:textme/data/model/api_profile.dart';
import 'package:textme/data/model/api_user.dart';
import 'package:textme/domain/user_info.dart';

class ProfileRepository {
  static const _BASE_URL = 'http://10.0.2.2:8000/';

  ProfileRepository();

  Future<http.StreamedResponse> getByUserId(int userId) async {
    var headers = {'Authorization': 'Bearer ' + currentSessionToken.token};
    var request = http.Request(
        'GET', Uri.parse(_BASE_URL + 'api/profiles/' + userId.toString()));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> update(ApiProfile profile) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('PUT', Uri.parse(_BASE_URL + 'api/profiles/'));
    request.body = json.encode({
      "descript": profile.descript,
      "age": profile.age,
      "Country": profile.country,
      "City": profile.city
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
