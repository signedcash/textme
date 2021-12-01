import 'package:flutter/material.dart';

class SignUp {
  String username;
  String name;
  String password;

  SignUp({
    @required this.username,
    @required this.name,
    @required this.password,
  });
}

class SignIn {
  String username;
  String password;

  SignIn({
    @required this.username,
    @required this.password,
  });
}

class SessionToken {
  String token;
  bool status;

  SessionToken({
    this.token,
    this.status,
  });
}
