import 'dart:convert';

import 'package:textme/domain/user_info.dart';
import 'package:textme/data/model/api_auth.dart';
import 'package:textme/data/repository/auth_repository.dart';
import 'package:textme/domain/model/auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final repo = AuthRepository();

  Future<http.StreamedResponse> signUp(SignUp input) async {
    return (this.repo.signUp(ApiSignUp(
        username: input.username, password: input.password, name: input.name)));
  }

  Future<http.StreamedResponse> signIn(SignIn input) async {
    http.StreamedResponse response = await this
        .repo
        .signIn(ApiSignIn(username: input.username, password: input.password));
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    if (response.statusCode == 200) {
      currentSessionToken.status = true;
      currentSessionToken.token = jsonResponse['token'];
    }
    return (response);
  }
}
