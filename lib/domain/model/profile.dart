import 'package:flutter/material.dart';
import 'package:textme/domain/model/user.dart';

class Profile {
  User user;
  String descript;
  int age;
  String country;
  String city;

  Profile({
    this.user,
    this.descript,
    this.age,
    this.country,
    this.city,
  });
}
