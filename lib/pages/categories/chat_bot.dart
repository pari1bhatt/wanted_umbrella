import 'package:flutter/material.dart';
import 'package:wanted_umbrella/models/userChat.dart';

import '../chat/message_screen.dart';
import '../../providers/chatProvider.dart';
import 'package:provider/provider.dart';

import '../dashboard_provider.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  final String chatBoaId = "8521";
  @override
  Widget build(BuildContext context) {
    ChatProvider chatProvider = Provider.of<ChatProvider>(context);
    DashboardProvider provider = Provider.of<DashboardProvider>(context);

    var currentUser = UserChat(name: provider.currentUserModel!.name,
        id: provider.currentUserModel!.id,
        email: provider.currentUserModel!.email,
        photo: provider.currentUserModel!.profile_image);

    var userChat  = UserChat(name: "Chatboat",id: chatBoaId);
    String roomId = chatProvider.getChatRoomID(provider.currentUserModel!.id.toString(), userChat.id.toString());
    return Scaffold(
      body: MessageScreen(isChatBot: true,userChat: userChat,currUser: currentUser,roomID: roomId),
    );
  }
}
