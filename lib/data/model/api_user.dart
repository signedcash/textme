import 'package:flutter/material.dart';

class ApiUser {
  final int id;
  final String username;
  final String name;
  final String imgUrl;

  ApiUser(
      {@required this.id,
      @required this.username,
      @required this.name,
      @required this.imgUrl});
}
