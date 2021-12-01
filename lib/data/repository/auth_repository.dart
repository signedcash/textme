import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:textme/data/model/api_auth.dart';
import 'package:http/http.dart' as http;

class AuthRepository {
  static const _BASE_URL = 'http://10.0.2.2:8000/';

  final Dio _dio = Dio(
    BaseOptions(contentType: 'application/json'),
  );

  AuthRepository();

  Future<http.StreamedResponse> signUp(ApiSignUp input) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('POST', Uri.parse(_BASE_URL + 'auth/sign-up'));
    request.body = input.toJson();
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> signIn(ApiSignIn input) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request('GET', Uri.parse(_BASE_URL + 'auth/sign-in'));
    request.body = input.toJson();
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }
}
