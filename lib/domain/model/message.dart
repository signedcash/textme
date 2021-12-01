import 'package:flutter/material.dart';
import 'package:textme/data/model/api_message.dart';
import 'package:textme/domain/model/user.dart';

class Message {
  int chatId;
  int senderId;
  String content;
  DateTime createdAt;

  Message({this.chatId, this.senderId, this.content, this.createdAt});
}
