import 'package:textme/data/service/auth_service.dart';
import 'package:textme/data/service/chat_service.dart';
import 'package:textme/data/service/message_service.dart';
import 'package:textme/data/service/profile_service.dart';
import 'package:textme/data/service/user_service.dart';

class ServiceUtil {
  ServiceUtil();

  final authService = AuthService();
  final userService = UserService();
  final profileService = ProfileService();
  final chatService = ChatService();
  final messageService = MessageService();
}
