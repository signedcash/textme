import 'dart:async';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/chat.dart';
import 'package:textme/domain/user_info.dart';
import 'package:intl/intl.dart';
import 'package:textme/presentation/chat_views/add_chat.dart';
import 'package:textme/presentation/chat_views/chat.dart';
import 'package:textme/presentation/profile_views/profile.dart';

class ChatListPage extends StatefulWidget {
  @override
  _ChatListPage createState() => _ChatListPage();
}

class _ChatListPage extends State<ChatListPage> {
  final StreamController _chatListController = StreamController();
  Stream get chatListController => _chatListController.stream;

  Stream<List<Chat>> chatListStream(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await ServiceUtil().chatService.getAllByUserId(currentUser.id);
    }
  }

  @override
  void dispose() {
    _chatListController.close();
    super.dispose();
  }

  addChat() {}

  Widget avatar(Chat chat) {
    return Container(
        margin: EdgeInsets.only(right: 15),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(38)),
                color: Color(0xffffffff),
              ),
            ),
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
                  backgroundImage: chat.sender.imgUrl == ""
                      ? null
                      : NetworkImage(chat.sender.imgUrl),
                  child: chat.sender.imgUrl == ""
                      ? Text('TM',
                          style: TextStyle(
                            fontSize: 32,
                            color: Color(0xee649bb3),
                          ))
                      : Container(),
                )
              ],
            ),
          ],
        ));
  }

  Widget dateTimeBlock(Chat chat) {
    return Container(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              DateFormat('dd MMM yy').format(chat.lastMessage.createdAt),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              DateFormat.jm().format(chat.lastMessage.createdAt),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget contentBlock(Chat chat) {
    return Container(
      width: 65.0 * MediaQuery.of(context).devicePixelRatio,
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              chat.sender.name,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              chat.lastMessage.content,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Chat>>(
        stream: chatListStream(Duration(milliseconds: 100)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: const Text(
                  'Chats',
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
                    icon: const Icon(EvaIcons.plusOutline),
                    tooltip: 'Add Chat',
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddChatPage()),
                    ),
                  ),
                ],
                leading: IconButton(
                  color: Colors.grey,
                  iconSize: 32,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  icon: const Icon(EvaIcons.arrowIosBackOutline),
                  onPressed: () => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => ProfilePage()),
                    (Route<dynamic> route) => false,
                  ),
                ),
              ),
              body: Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: ClipRRect(
                      child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            final Chat chat = snapshot.data[index];
                            if (chat.lastMessage.chatId != null)
                              return GestureDetector(
                                  onTap: () {
                                    currentChat = chat;
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ChatPage(),
                                        ));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 7.0, horizontal: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.0, vertical: 10.0),
                                    decoration: BoxDecoration(
                                      color: Color(0xffffffff),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black38,
                                          spreadRadius: 1,
                                          blurRadius: 4,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15.0)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        avatar(chat),
                                        contentBlock(chat),
                                        SizedBox(width: 10.0),
                                        dateTimeBlock(chat)
                                      ],
                                    ),
                                  ));
                            else
                              return Container();
                          }))),
            );
          } else {
            return Scaffold(
                appBar: AppBar(
                  centerTitle: true,
                  title: const Text(
                    'Chats',
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
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => ProfilePage()),
                      (Route<dynamic> route) => false,
                    ),
                  ),
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
