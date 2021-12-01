import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/chat.dart';
import 'package:textme/domain/model/user.dart';
import 'package:textme/domain/user_info.dart';
import 'package:textme/presentation/chat_views/chat.dart';

class AddChatPage extends StatefulWidget {
  @override
  _AddChatPage createState() => _AddChatPage();
}

class _AddChatPage extends State<AddChatPage> {
  final StreamController _addChatController = StreamController();
  Stream get addChatController => _addChatController.stream;

  TextEditingController usernameTextController = TextEditingController();

  Stream<User> addChatStream(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await ServiceUtil()
          .userService
          .getByUsername(usernameTextController.text);
    }
  }

  @override
  void dispose() {
    _addChatController.close();
    super.dispose();
  }

  addChat(User user) async {
    Chat chat = await ServiceUtil().chatService.getByUserId(user.id);
    if (chat.id != null) {
      if (!chat.vision) {
        ServiceUtil()
            .chatService
            .updateVision(currentUser.id, chat.sender.id, !chat.vision);
      }
      currentChat = chat;
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => ChatPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      if (true ==
          await ServiceUtil().chatService.create(currentUser.id, user.id)) {
        Chat chat = await ServiceUtil().chatService.getByUserId(user.id);
        currentChat = chat;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => ChatPage()),
          (Route<dynamic> route) => false,
        );
      }
    }
  }

  Widget userBlock(BuildContext context, User user) {
    if (user.id == null || user.id == currentUser.id) return Container();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 2, vertical: 30),
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
                        margin: EdgeInsets.symmetric(vertical: 5),
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
                        backgroundImage: user.imgUrl == ""
                            ? null
                            : NetworkImage(user.imgUrl),
                        child: user.imgUrl == ""
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
                          width: 180,
                          child: Text(
                            "${user.name}",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.blueGrey[700],
                            ),
                          ),
                        ),
                        Container(
                          height: 30,
                          width: 180,
                          child: Text(
                            "@" + "${user.username}",
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
                  IconButton(
                    color: Colors.grey,
                    iconSize: 45,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    icon: const Icon(EvaIcons.plusCircleOutline),
                    tooltip: 'Add Chat',
                    onPressed: () => addChat(user),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Add Chat',
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
        leading: IconButton(
          color: Colors.grey,
          iconSize: 32,
          padding: EdgeInsets.symmetric(horizontal: 10),
          icon: const Icon(EvaIcons.arrowIosBackOutline),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 0,
                ),
                width: 350,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20), bottom: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      spreadRadius: 1,
                      blurRadius: 4,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 95.0 * MediaQuery.of(context).devicePixelRatio,
                      child: TextField(
                        keyboardType: TextInputType.name,
                        enableSuggestions: false,
                        autocorrect: false,
                        style: TextStyle(
                          color: Colors.blueGrey[700],
                          fontSize: 16.0,
                        ),
                        controller: usernameTextController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Enter the username...",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                  stream: addChatStream(Duration(seconds: 1)),
                  builder: (context, snapshot) {
                    if (snapshot.hasData)
                      return userBlock(context, snapshot.data);
                    else
                      return Container();
                  })
            ],
          ),
        ),
      ),
    );
  }
}
