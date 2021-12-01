import 'package:flutter/material.dart';

class ApiMessage {
  final int chatId;
  final int senderId;
  final String content;
  final String createdAt;

  ApiMessage({this.chatId, this.senderId, this.content, this.createdAt});

  factory ApiMessage.fromJson(dynamic json) {
    return ApiMessage(
      chatId: json['chat_id'] as int,
      senderId: json['sender_id'] as int,
      content: json['content'] as String,
      createdAt: json['created_at'] as String,
    );
  }
}
