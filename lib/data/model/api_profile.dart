import 'package:flutter/material.dart';

class ApiProfile {
  final int userId;
  final String descript;
  final int age;
  final String country;
  final String city;

  ApiProfile(
      {@required this.userId,
      @required this.descript,
      @required this.age,
      @required this.country,
      @required this.city});
}
