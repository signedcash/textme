import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:intl/intl.dart';
import 'package:textme/data/model/api_auth.dart';
import 'package:http/http.dart' as http;
import 'package:textme/domain/model/message.dart';
import 'package:textme/domain/user_info.dart';

class MessageRepository {
  static const _BASE_URL = 'http://10.0.2.2:8000/';

  MessageRepository();

  Future<http.StreamedResponse> getLastByChatId(int chatId) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET', Uri.parse(_BASE_URL + 'api/messages/last/' + chatId.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> getAllByChatId(int chatId) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request(
        'GET', Uri.parse(_BASE_URL + 'api/messages/' + chatId.toString()));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> create(Message message) async {
    var headers = {
      'Authorization': 'Bearer ' + currentSessionToken.token,
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse(_BASE_URL + 'api/messages/'));
    request.body = json.encode({
      "chat_id": message.chatId,
      "sender_id": message.senderId,
      "content": message.content,
      "created_at": DateFormat('yyyy-MM-dd HH:mm:ss').format(message.createdAt)
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
