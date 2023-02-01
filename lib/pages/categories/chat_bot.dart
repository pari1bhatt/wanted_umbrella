import 'package:flutter/material.dart';
import 'package:wanted_umbrella/models/userChat.dart';

import '../../utils/firestore_constants.dart';
import '../chat/message_screen.dart';
import '../../providers/chatProvider.dart';
import 'package:provider/provider.dart';

import '../dashboard_provider.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  final String chatBoaId = "rN7KI3Ba5EXVuRheD0M0OU7dcGu1";
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

    chatProvider.getChatRoom(roomId).then((querySnapShot) {
      if (querySnapShot.docs.length == 0) {
        // if we didn't have this room before
        // create a room
        List<String> user = [
          provider.currentUserModel!.id.toString(),
          userChat.id.toString()
        ];
        Map<String, dynamic> mapRoom = {
          FirestoreContants.roomID_room: roomId,
          FirestoreContants.UserID_room: user,
        };
        chatProvider.createChatRoom(roomId, mapRoom);
      } else {
        // if we had this room before
        // do nothing
        print("we had this room before");
      }
      print("chatProvider.roomId ${roomId} =>Logged in ${provider
          .currentUserModel!.name} toChat ${userChat.name}");
    });

    return Scaffold(
      body: MessageScreen(isChatBot: true,userChat: userChat,currUser: currentUser,roomID: roomId),
    );
  }
}
