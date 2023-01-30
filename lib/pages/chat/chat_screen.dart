import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/userChat.dart';
import '../../models/user_model.dart';
import '../../providers/chatProvider.dart';
import '../../utils/firestore_constants.dart';
import '../dashboard_provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  late Size size;

  late DashboardProvider provider;
  late ChatProvider chatProvider;
  String myUserId = "";

  @override
  Widget build(BuildContext context) {
    return getBody();
  }

  Widget getBody() {
    size = MediaQuery
        .of(context)
        .size;
    provider = Provider.of<DashboardProvider>(context);
    chatProvider = Provider.of<ChatProvider>(context);
    myUserId = provider.currentUserModel!.id!;
    return SafeArea(
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Divider(thickness: 2),
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 0, right: 8),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                  color: GetColors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(5)),
              child: TextField(
                cursorColor: GetColors.black.withOpacity(0.5),
                decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                      color: GetColors.black.withOpacity(0.5),
                    ),
                    hintText: "Search"),
              ),
            ),
          ),
          (provider.currentUserModel?.matchRequests.isEmpty ?? true)
              ? const SizedBox()
              : const Padding(
            padding: EdgeInsets.only(left: 15, bottom: 10, top: 10),
            child: Text(
              "Pending matches",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: GetColors.purple),
            ),
          ),
          (provider.currentUserModel?.matchRequests.isEmpty ?? true)
              ? const SizedBox()
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                  provider.currentUserModel?.matchRequests.length ?? 0,
                      (index) =>
                      FutureBuilder<DocumentSnapshot>(
                          future: FirebaseFirestore.instance
                              .doc("users/${provider.currentUserModel
                              ?.matchRequests[index].id}")
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasError) {
                              return const Text("Something went wrong");
                            }
                            if (snapshot.hasData && !snapshot.data!.exists) {
                              return const Text("Document does not exist");
                            }
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              UserModel innerModel =
                              UserModel.fromJson(snapshot.data?.data() as Map);
                              innerModel.id = snapshot.data?.id;
                              return Card(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                          "${innerModel
                                              .name} has requested for a match\nDog name: ${innerModel
                                              .dog_name}\nDog breed: ${innerModel
                                              .breed}"),
                                      const SizedBox(width: 15),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                            backgroundColor: GetColors.purple),
                                        onPressed: onMatchClick,
                                        child: const Text(
                                          "Match",
                                          style: TextStyle(
                                              color: GetColors.white),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }
                            return Container();
                          })),
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text(
              "Your recent matches",
              style: TextStyle(fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: GetColors.purple),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: (provider.currentUserModel?.matchAccepted.isEmpty ?? true)
                ? getMatchToChat()
                : Padding(
                  padding: const EdgeInsets.all(10),
                  child: ChatList(),
                ),
          )
        ],
      ),
    );
  }

  Widget ChatList() {
    print('matches full: ${provider.currentUserModel?.matchAccepted}');
    List<String> matchList = [];
    for (int i = 0; i < provider.currentUserModel!.matchAccepted.length; i++) {
      matchList.add(provider.currentUserModel!.matchAccepted[i].id);
    }

    print('matches array ${matchList}');
    return StreamBuilder<QuerySnapshot>(
      stream: chatProvider.getMemberList(matchList),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          print("data users ${snapshot.data!.docs.length}");
          List<UserChat> userList = [];
          for (int i = 0; i < snapshot.data!.docs.length; i++) {
            //var uid = snapshot.data!.docs[i][FirestoreContants.id_user];
            /* if (uid == myUserId) {
              continue;
            }*/
            userList.add(UserChat(
                email: snapshot.data!.docs[i][FirestoreContants.email_user],
                id: snapshot.data!.docs[i].id,
                name: snapshot.data!.docs[i][FirestoreContants.name_user],
                photo: snapshot.data!.docs[i][FirestoreContants.photo_user]));
            print("userid - ${userList[i].id}");
          }

          return ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) {
              return singleMember(userList[index]);
            },
          );
        } else
          return Center(
            child: Text("Loading."),
          );
      },
    );
  }

  Widget singleMember(UserChat userChat) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 18),
      child: InkWell(
        onTap: () {
          String roomId = chatProvider.getChatRoomID(provider.currentUserModel!
              .id.toString(), userChat.id.toString());

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
              chatProvider..createChatRoom(roomId, mapRoom);
            } else {
              // if we had this room before
              // do nothing
              print("we had this room before");
            }
            print("chatProvider.roomId ${roomId} =>Logged in ${provider
                .currentUserModel!.name} toChat ${userChat.name}");

            var currentUser = UserChat(name: provider.currentUserModel!.name,
                id: provider.currentUserModel!.id,
            email: provider.currentUserModel!.email,
            photo: provider.currentUserModel!.profile_image);

            Navigator.pushNamed(
                context, Routes.messege, arguments: [roomId,currentUser,userChat]);
          });
        },
        child: Row(
          children: <Widget>[
            SizedBox(
              width: 70,
              height: 70,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: GetColors.purple, width: 3)),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(userChat.photo!),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  // If user online then show green dot
                  true
                      ? Positioned(
                    top: 48,
                    left: 52,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                          color: GetColors.green,
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: GetColors.white, width: 3)),
                    ),
                  )
                      : Container()
                ],
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  userChat.name ?? "",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width - 135,
                  child: Text(
                    "Message - 1:00 pm",
                    style: TextStyle(
                        fontSize: 15, color: GetColors.black.withOpacity(0.8)),
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  getMatchToChat() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * .15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: GetColors.purple.withOpacity(0.15),
            child: const Icon(
              Icons.message_outlined,
              size: 30,
              color: GetColors.purple,
            ),
          ),
          const SizedBox(height: 8),
          const Text("Match to chat",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          const Text(GetStrings.emptyChatMessage,
              textAlign: TextAlign.center, style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  onMatchClick() {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Confirmation',
      desc: 'Are you sure you want to accept?',
      btnCancelOnPress: () =>
          Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
      btnOkOnPress: () =>
          Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
    ).show();
  }
}
