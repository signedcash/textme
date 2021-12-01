import 'package:flutter/material.dart';

class ApiChat {
  int id;
  int user1Id;
  int user2Id;
  int vision1;
  int vision2;

  ApiChat(
      {@required this.id,
      @required this.user1Id,
      @required this.user2Id,
      @required this.vision1,
      @required this.vision2});

  factory ApiChat.fromJson(dynamic json) {
    return ApiChat(
      id: json['id'] as int,
      user1Id: json['user1_id'] as int,
      user2Id: json['user2_id'] as int,
      vision1: json['vision_1'] as int,
      vision2: json['vision_2'] as int,
    );
  }
}
