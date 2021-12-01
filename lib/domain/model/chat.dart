import 'package:flutter/material.dart';
import 'package:textme/data/model/api_message.dart';
import 'package:textme/domain/model/message.dart';
import 'package:textme/domain/model/user.dart';

class Chat {
  int id;
  User sender;
  Message lastMessage;
  bool vision;

  Chat({this.id, this.sender, this.lastMessage, this.vision});
}
