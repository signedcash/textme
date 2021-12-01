import 'dart:convert';

import 'package:textme/data/model/api_profile.dart';
import 'package:textme/data/model/api_user.dart';
import 'package:textme/data/repository/profile_repository.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/profile.dart';
import 'package:textme/domain/model/user.dart';
import 'package:http/http.dart' as http;
import 'package:textme/domain/user_info.dart';

class ProfileService {
  final repo = ProfileRepository();

  Future<Profile> getProfileByUser(User user) async {
    Profile profile = Profile();
    http.StreamedResponse response = await this.repo.getByUserId(user.id);
    String body = await response.stream.bytesToString();
    var jsonResponse = jsonDecode(body);
    if (response.statusCode == 200) {
      profile.descript = jsonResponse['descript'];
      profile.age = jsonResponse['age'];
      profile.country = jsonResponse['country'];
      profile.city = jsonResponse['city'];
    }
    user = await ServiceUtil().userService.getById(user.id);
    profile.user = user;

    return profile;
  }

  Future<bool> update(Profile profile) async {
    ApiProfile newProfile = ApiProfile(
        userId: profile.user.id,
        descript: profile.descript,
        age: profile.age,
        country: profile.country,
        city: profile.city);
    bool userIsUpdate = await ServiceUtil().userService.update(profile.user);
    http.StreamedResponse responseProfile = await this.repo.update(newProfile);
    return userIsUpdate && responseProfile.statusCode == 200 ? true : false;
  }
}
