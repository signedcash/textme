import 'dart:convert';
import 'package:flutter/material.dart';

class ApiSignUp {
  final String username;
  final String name;
  final String password;

  ApiSignUp(
      {@required this.username, @required this.name, @required this.password});

  String toJson() {
    return json.encode({
      'username': this.username,
      'password': this.password,
      'name': this.name
    });
  }
}

class ApiSignIn {
  final String username;
  final String password;

  ApiSignIn({@required this.username, @required this.password});

  String toJson() {
    return json.encode({
      'username': this.username,
      'password': this.password,
    });
  }
}

class ApiSessionToken {
  String token;

  ApiSessionToken({@required this.token});

  factory ApiSessionToken.fromJson(dynamic json) {
    return ApiSessionToken(token: json['token'] as String);
  }
}
