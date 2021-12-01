import 'package:flutter/material.dart';
import 'package:textme/domain/user_info.dart';
import 'package:textme/presentation/auth_views/signin.dart';
import 'package:textme/presentation/chat_views/add_chat.dart';
import 'package:textme/presentation/chat_views/chat.dart';
import 'package:textme/presentation/chat_views/chat_list.dart';
import 'package:textme/presentation/profile_views/profile.dart';
import 'package:textme/presentation/profile_views/setting.dart';

class Application extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TEXTME',
      routes: <String, WidgetBuilder>{
        '/chatListPage': (BuildContext context) => new ChatListPage(),
        '/chatPage': (BuildContext context) => new ChatPage(),
        '/settingsPage': (BuildContext context) => new SettingsPage(),
        '/addChatPage': (BuildContext context) => new AddChatPage()
      },
      theme: ThemeData(
        fontFamily: 'Raleway',
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: currentSessionToken.status ? ProfilePage() : SignInPage(),
    );
  }
}
