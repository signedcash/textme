import 'dart:convert';

import 'package:textme/data/model/api_user.dart';
import 'package:textme/data/repository/user_repository.dart';
import 'package:http/http.dart' as http;
import 'package:textme/domain/model/user.dart';
import 'package:textme/domain/user_info.dart';

class UserService {
  final repo = UserRepository();

  Future<http.StreamedResponse> getCurrentUser() async {
    http.StreamedResponse response = await this.repo.getCurrentUser();
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    if (response.statusCode == 200) {
      currentUser.id = jsonResponse['id'];
      currentUser.username = jsonResponse['username'];
      currentUser.name = jsonResponse['name'];
      currentUser.imgUrl = jsonResponse['img_url'];
    }
    return response;
  }

  Future<User> getById(int id) async {
    http.StreamedResponse response = await this.repo.getById(id);
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    return User(
        id: jsonResponse['id'],
        username: jsonResponse['username'],
        name: jsonResponse['name'],
        imgUrl: jsonResponse['img_url']);
  }

  Future<User> getByUsername(String username) async {
    http.StreamedResponse response = await this.repo.getByUsername(username);
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    return User(
        id: jsonResponse['id'],
        username: jsonResponse['username'],
        name: jsonResponse['name'],
        imgUrl: jsonResponse['img_url']);
  }

  Future<bool> update(User user) async {
    ApiUser newUser = ApiUser(
        id: user.id,
        username: user.username,
        name: user.name,
        imgUrl: user.imgUrl);
    http.StreamedResponse response = await this.repo.update(newUser);
    return response.statusCode == 200 ? true : false;
  }
}
