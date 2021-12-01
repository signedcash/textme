import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:textme/data/model/api_auth.dart';
import 'package:http/http.dart' as http;
import 'package:textme/data/model/api_chat.dart';
import 'package:textme/domain/user_info.dart';

class ChatRepository {
  static const _BASE_URL = 'http://10.0.2.2:8000/';

  ChatRepository();

  Future<http.StreamedResponse> getAllByUserId() async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(_BASE_URL + 'api/chats/'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> getByUserId(int userId) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET', Uri.parse(_BASE_URL + 'api/chats/' + userId.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> update(ApiChat chat) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'PUT', Uri.parse(_BASE_URL + 'api/chats/' + chat.id.toString()));
    request.body = json.encode({
      "user1_id": chat.user1Id,
      "user2_id": chat.user2Id,
      "vision_1": chat.vision1,
      "vision_2": chat.vision2
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> create(int currUser, int otherUser) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(_BASE_URL + 'api/chats/'));
    request.body = json.encode({
      "user1_id": currUser,
      "user2_id": otherUser,
      "vision_1": 1,
      "vision_2": 1
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
