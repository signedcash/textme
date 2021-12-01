import 'dart:convert';

import 'package:textme/data/model/api_chat.dart';
import 'package:textme/data/model/api_message.dart';
import 'package:textme/data/model/api_profile.dart';
import 'package:textme/data/model/api_user.dart';
import 'package:textme/data/repository/chat_repository.dart';
import 'package:textme/data/repository/message_repository.dart';
import 'package:textme/data/repository/profile_repository.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/chat.dart';
import 'package:textme/domain/model/message.dart';
import 'package:textme/domain/model/profile.dart';
import 'package:textme/domain/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:textme/domain/user_info.dart';

class MessageService {
  final repo = MessageRepository();

  Future<Message> getLastByChatId(int chatId) async {
    http.StreamedResponse response = await this.repo.getLastByChatId(chatId);
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    if (response.statusCode == 200)
      return Message(
        chatId: jsonResponse['chat_id'],
        senderId: jsonResponse['sender_id'],
        content: jsonResponse['content'],
        createdAt: DateTime.parse(jsonResponse['created_at']),
      );
    else
      return Message();
  }

  Future<bool> create(Message message) async {
    http.StreamedResponse response = await this.repo.create(message);
    return (response.statusCode == 200 ? true : false);
  }

  Future<List<Message>> getAllByChatId(int chatId) async {
    http.StreamedResponse response = await this.repo.getAllByChatId(chatId);
    String body = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      var jsonList = jsonDecode(body) as List;
      List<ApiMessage> apiMessages =
          jsonList.map((chatJson) => ApiMessage.fromJson(chatJson)).toList();
      List<Message> chats =
          await Future.wait(apiMessages.map((apiMessage) async {
        return Message(
            chatId: apiMessage.chatId,
            senderId: apiMessage.senderId,
            content: apiMessage.content,
            createdAt: DateTime.parse(apiMessage.createdAt));
      }));
      return chats;
    } else {
      return List<Message>();
    }
  }
}
