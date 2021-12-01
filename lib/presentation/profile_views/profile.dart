import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/profile.dart';
import 'package:textme/domain/user_info.dart';
import 'package:textme/presentation/auth_views/signin.dart';
import 'package:textme/presentation/chat_views/chat_list.dart';
import 'package:textme/presentation/profile_views/setting.dart';

class ProfilePage extends StatefulWidget {
  final Profile profile;

  ProfilePage({this.profile});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final StreamController _profileController = StreamController();
  Stream get profileController => _profileController.stream;

  Stream<Profile> profileStream(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await ServiceUtil().profileService.getProfileByUser(currentUser);
    }
  }

  @override
  void dispose() {
    _profileController.close();
    super.dispose();
  }

  void signOut() {
    currentSessionToken.status = false;
    currentSessionToken.token = "";
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) => SignInPage(),
      ),
      (Route<dynamic> route) => false,
    );
  }

  Widget customButton(
      BuildContext context, Widget screen, IconData icon, String text) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => screen),
      ),
      child: Container(
          width: MediaQuery.of(context).size.width / 3 - 16,
          margin: EdgeInsets.only(left: 10, right: 10),
          padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                color: Colors.blueGrey,
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(
                icon,
                color: Colors.grey[600],
                size: 32,
              ),
              Text(
                text,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 18,
                ),
              ),
            ],
          )),
    );
  }

  Widget userInfo(BuildContext context, Profile profile) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black38,
            spreadRadius: 2,
            blurRadius: 4,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.all(Radius.circular(38)),
        color: Colors.grey[100],
      ),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 77,
                        height: 77,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blueGrey,
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                          borderRadius: BorderRadius.all(Radius.circular(38)),
                          color: Color(0xcc83e2f7),
                        ),
                      ),
                      CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.white,
                        backgroundImage: profile.user.imgUrl == ""
                            ? null
                            : NetworkImage(profile.user.imgUrl),
                        child: profile.user.imgUrl == ""
                            ? Text('TM',
                                style: TextStyle(
                                  fontSize: 32,
                                  color: Color(0xee649bb3),
                                ))
                            : Container(),
                      )
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            "${profile.user.name}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            "City: " +
                                (profile.city == ""
                                    ? "None"
                                    : "${profile.city}"),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            "Country: " +
                                (profile.country == ""
                                    ? "None"
                                    : "${profile.country}"),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: MediaQuery.of(context).size.width - 150,
                          child: Text(
                            "Age: " +
                                (profile.age == 0 ? "None" : "${profile.age}"),
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 5, right: 10, left: 10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 2),
                      width: double.infinity,
                      child: Text(
                        'Description:',
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        top: 5,
                        bottom: 5,
                      ),
                      width: double.infinity,
                      child: Text(
                        profile.descript == ""
                            ? profile.user.name + " has not added a description"
                            : profile.descript,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 16.0,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Profile>(
        stream: profileStream(Duration(milliseconds: 500)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'TEXTME',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black38,

                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        )
                      ],
                      color: Color(0xcc83efff),
                      fontSize: 42,
                    ),
                  ),
                  backgroundColor: Colors.white,
                  actions: <Widget>[
                    IconButton(
                      color: Colors.grey,
                      iconSize: 32,
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      icon: const Icon(EvaIcons.logOutOutline),
                      tooltip: 'Sign Out',
                      onPressed: () => signOut(),
                    ),
                  ],
                ),
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(
                            10,
                            MediaQuery.of(context).padding.top.toDouble(),
                            10,
                            15),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: userInfo(context, snapshot.data),
                      ),
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              customButton(context, ChatListPage(),
                                  EvaIcons.messageCircleOutline, "Chats"),
                              customButton(context, SettingsPage(),
                                  EvaIcons.settingsOutline, "Setting")
                            ],
                          )),
                    ],
                  ),
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'TEXTME',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                        Shadow(
                          color: Colors.black38,

                          blurRadius: 4,
                          offset: Offset(0, 2), // changes position of shadow
                        )
                      ],
                      color: Color(0xcc83efff),
                      fontSize: 42,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
                body: Container(
                  child: Center(
                    child: Text(
                      "Loading...",
                      style: TextStyle(color: Colors.white, fontSize: 28),
                    ),
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ));
          }
        });
  }
}
