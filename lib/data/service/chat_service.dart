import 'dart:convert';

import 'package:textme/data/model/api_chat.dart';
import 'package:textme/data/model/api_profile.dart';
import 'package:textme/data/model/api_user.dart';
import 'package:textme/data/repository/chat_repository.dart';
import 'package:textme/data/repository/profile_repository.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/chat.dart';
import 'package:textme/domain/model/message.dart';
import 'package:textme/domain/model/profile.dart';
import 'package:textme/domain/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:textme/domain/user_info.dart';

class ChatService {
  final repo = ChatRepository();

  Future<List<Chat>> getAllByUserId(int id) async {
    http.StreamedResponse response = await this.repo.getAllByUserId();
    String body = await response.stream.bytesToString();
    if (response.statusCode == 200 && body != "null") {
      var jsonList = jsonDecode(body) as List;
      List<ApiChat> apiChats =
          jsonList.map((chatJson) => ApiChat.fromJson(chatJson)).toList();
      List<Chat> chats = await Future.wait(apiChats.map((apiChat) async {
        User sender = await ServiceUtil()
            .userService
            .getById(apiChat.user1Id == id ? apiChat.user2Id : apiChat.user1Id);
        Message lastMessage =
            await ServiceUtil().messageService.getLastByChatId(apiChat.id);
        return Chat(
            id: apiChat.id,
            sender: sender,
            lastMessage: lastMessage,
            vision:
                (apiChat.user1Id == id ? apiChat.vision1 : apiChat.vision2) == 1
                    ? true
                    : false);
      }));
      return chats;
    } else
      return List<Chat>();
  }

  Future<Chat> getByUserId(int userId) async {
    http.StreamedResponse response = await this.repo.getByUserId(userId);
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    int user1Id = jsonResponse['user1_id'];
    User sender = await ServiceUtil()
        .userService
        .getById(user1Id == userId ? user1Id : jsonResponse['user2_id']);
    Message lastMessage =
        await ServiceUtil().messageService.getLastByChatId(jsonResponse['id']);
    return Chat(
        id: jsonResponse['id'],
        sender: sender,
        lastMessage: lastMessage,
        vision: (user1Id == jsonResponse['id']
                    ? jsonResponse['vision_1']
                    : jsonResponse['vision_2']) ==
                1
            ? true
            : false);
  }

  Future<bool> updateVision(int curUserId, int userId, bool vision) async {
    http.StreamedResponse response = await this.repo.getByUserId(userId);
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    ApiChat apiChat = await ApiChat.fromJson(jsonResponse);
    if (apiChat.user1Id == curUserId)
      apiChat.vision1 = vision ? 1 : 0;
    else
      apiChat.vision2 = vision ? 1 : 0;

    http.StreamedResponse response2 = await this.repo.update(apiChat);

    return response2.statusCode == 200 ? true : false;
  }

  Future<bool> create(int currUser, int otherUser) async {
    http.StreamedResponse response =
        await this.repo.create(currUser, otherUser);
    return (response.statusCode == 200 ? true : false);
  }
}
