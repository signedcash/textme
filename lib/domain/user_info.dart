import 'package:textme/domain/model/auth.dart';
import 'package:textme/domain/model/chat.dart';
import 'package:textme/domain/model/user.dart';
import 'model/profile.dart';

SessionToken currentSessionToken = SessionToken(status: false);
Profile currentProfile = Profile();
User otherUser = User();
User currentUser = User();
Chat currentChat = Chat();

String linkIcon = "https://klike.net/uploads/posts/2020-07/1593759973_9.jpg";
