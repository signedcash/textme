import 'dart:async';
import 'dart:ui';

import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:textme/data/service_util.dart';
import 'package:textme/domain/model/chat.dart';
import 'package:textme/domain/model/message.dart';
import 'package:intl/intl.dart';
import 'package:textme/domain/user_info.dart';
import 'package:textme/presentation/chat_views/chat_list.dart';
import 'package:textme/presentation/profile_views/other_profile.dart';
import 'package:textme/presentation/profile_views/profile.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController messageTextController = TextEditingController();

  final StreamController _messageListController = StreamController();
  Stream get messageListController => _messageListController.stream;

  Stream<List<Message>> messageListStream(Duration refreshTime) async* {
    while (true) {
      await Future.delayed(refreshTime);
      yield await ServiceUtil().messageService.getAllByChatId(currentChat.id);
    }
  }

  @override
  void dispose() {
    _messageListController.close();
    super.dispose();
  }

  sendMessage() async {
    if (messageTextController.text.isNotEmpty) {
      Message message = Message(
          chatId: currentChat.id,
          senderId: currentUser.id,
          content: messageTextController.text,
          createdAt: DateTime.now());
      messageTextController.text = "";
      bool status = await ServiceUtil().messageService.create(message);
      if (!status) _showAlert(context);
    }
  }

  void _showAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Text("Oops..."),
        content: Text("Sending error"),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void _confirmAlert(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        title: Text("Сonfirm your actions"),
        content: Text("Do you actually want to delete this chat?"),
        actions: [
          TextButton(
            child: Text('Confirm'),
            onPressed: () {
              ServiceUtil()
                  .chatService
                  .updateVision(currentUser.id, currentChat.sender.id, false);
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => ChatListPage()),
                (Route<dynamic> route) => false,
              );
            },
          ),
          TextButton(
            child: Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  _buildMessage(Message message, bool isMe) {
    final Container msg = Container(
      margin: isMe
          ? EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              left: 80.0,
            )
          : EdgeInsets.only(
              top: 8.0,
              bottom: 8.0,
              right: 80.0,
            ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Colors.white : Colors.white70,
        borderRadius: isMe
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
      ),
      child: Column(
        children: <Widget>[
          Align(
            alignment: isMe ? Alignment.topLeft : Alignment.topRight,
            child: Text(
              DateFormat('dd MMM yy').format(message.createdAt),
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 12.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 2.0),
          Align(
            alignment: isMe ? Alignment.topRight : Alignment.topLeft,
            child: Text(
              message.content,
              style: TextStyle(
                color: Colors.blueGrey,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Align(
            alignment: isMe ? Alignment.topLeft : Alignment.topRight,
            child: Text(
              DateFormat.jm().format(message.createdAt),
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
    return msg;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Message>>(
        stream: messageListStream(Duration(milliseconds: 100)),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    currentChat.sender.name,
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
                      fontSize: 27,
                    ),
                  ),
                  actions: <Widget>[
                    IconButton(
                        color: Colors.grey,
                        iconSize: 32,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        icon: const Icon(EvaIcons.personOutline),
                        tooltip: 'Open profile',
                        onPressed: () {
                          otherUser = currentChat.sender;
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => OtherProfilePage()),
                          );
                        }),
                    IconButton(
                        color: Colors.grey,
                        iconSize: 32,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        icon: const Icon(EvaIcons.trashOutline),
                        tooltip: 'Delete Chat',
                        onPressed: () => _confirmAlert(context)),
                  ],
                  leading: IconButton(
                    color: Colors.grey,
                    iconSize: 32,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    icon: const Icon(EvaIcons.arrowIosBackOutline),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => ChatListPage()),
                      (Route<dynamic> route) => false,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
                body: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xcc83e2f7), Color(0xcc50bce2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: GestureDetector(
                    onTap: () => FocusScope.of(context).unfocus(),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xcc83e2f7),
                                    Color(0xcc50bce2)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: ListView.builder(
                                  padding: EdgeInsets.only(top: 15.0),
                                  reverse: true,
                                  itemCount: snapshot.data == null
                                      ? 0
                                      : snapshot.data.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Message message = snapshot
                                        .data[snapshot.data.length - index - 1];
                                    final bool isMe = message.senderId !=
                                        currentChat.sender.id;
                                    return _buildMessage(message, isMe);
                                  })),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          height: 70.0,
                          color: Colors.white,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: TextField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  controller: messageTextController,
                                  onChanged: (value) {},
                                  decoration: InputDecoration.collapsed(
                                    hintText: 'Send a message...',
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.send),
                                iconSize: 25.0,
                                color: Color(0xcc83efff),
                                onPressed: () => sendMessage(),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ));
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text(
                    currentChat.sender.name,
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
                      fontSize: 32,
                    ),
                  ),
                  leading: IconButton(
                    color: Colors.grey,
                    iconSize: 32,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    icon: const Icon(EvaIcons.arrowIosBackOutline),
                    onPressed: () => Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => ChatListPage()),
                      (Route<dynamic> route) => false,
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
