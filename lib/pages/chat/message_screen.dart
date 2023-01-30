import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wanted_umbrella/models/chat_message.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/userChat.dart';
import '../../providers/chatProvider.dart';
import '../../utils/firestore_constants.dart';
import 'package:provider/provider.dart';

import '../on_boarding/on_boarding_provider.dart';

class MessageScreen extends StatefulWidget {
  final bool isChatBot;

  /*final String roomID;
    final UserChat currUser;*/
  final UserChat? userChat;


  const MessageScreen(
      {this.isChatBot = false,
        required this.userChat,
        /*required this.roomID,
        required this.userChat,
        required this.currUser,*/
    Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {

  final chatInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool haveText = false;
  bool needJump_toEnd = false;


  @override
  void dispose() {
    chatInputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
  // handle send message
  void handleSend_message(ChatProvider chatProvider) {
    if (haveText) {
      setState(() {
        needJump_toEnd = true;
      });

      ChatMessage chatMessage = new ChatMessage(
        roomID: chatProvider.roomId,//widget.roomID,
        FromUser: chatProvider.currentUserId,//widget.currUser.id.toString(),
        text: chatInputController.text,
        type: FirestoreContants.type_message_text,
        time: DateTime.now().toString(),
      );
      chatProvider.sendChatMessage(chatMessage, chatProvider.roomId/*widget.roomID*/).then((value) {
        chatInputController.text = "";
        // show send animation
        _scrollController.animateTo(_scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
        stop_sendAnimation();
        setState(() {
          haveText = false;
        });
      });
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.grey);
    }
  }

  // stop send animation for receive message after 300 milliseconds
  // becase we need 300 milliseconds to show animation send
  void stop_sendAnimation() async {
    await Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        needJump_toEnd = false;
      });
    });
  }

  void autoScroll_toEnd() {
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    } else {
      setState(() => null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
      appBar: buildAppbar(context,chatProvider),
      body: buildBody(context,chatProvider),
    );
  }

  // appbar
  AppBar buildAppbar(BuildContext context,ChatProvider chatProvider) {
    return AppBar(
      leadingWidth: 40,
      elevation: 2,
      centerTitle: true,
      title: widget.isChatBot
          ? Text("Chatbot")
          : Row(
              children: [
                const CircleAvatar(backgroundImage: AssetImage(GetImages.dog3), radius: 22),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.userChat!.name!,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black.withOpacity(0.7),
                      ),
                    ),
                    const Text("Active 3m ago", style: TextStyle(fontSize: 12)),
                  ],
                )
              ],
            ),
      actions: widget.isChatBot
          ? []
          : [
              IconButton(icon: const Icon(Icons.person), onPressed: () {}),
              const SizedBox(width: 7),
            ],
    );
  }

  // body
  SafeArea buildBody(BuildContext context,ChatProvider chatProvider) {
    return SafeArea(
        child: Container(
      color: Colors.grey.withOpacity(0.00),
      child: Column(
        children: [
          Expanded(
            child: ChatMessageList(chatProvider),
          ),
          chatInputField(chatProvider),
        ],
      ),
    ));
  }

  // list message
  Widget ChatMessageList(ChatProvider chatProvider) {
    return StreamBuilder<QuerySnapshot>(
      stream: chatProvider.getMessageWithChatroomID(chatProvider.roomId/*widget.roomID*/),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          // if we got data
          if (snapshot.data!.docs.length == 0) {
            // if they haven't sent message

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(widget.isChatBot ? GetImages.robot_icon : GetImages.dog3),
                    radius: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.isChatBot ? "Chatbot" :"Bunty",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("Say hello..."),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            );
          } else {
            // if they have sent message
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              // when we sen message we need the send animation,
              // but when we got the receive message we don't need animation
              if (!needJump_toEnd) autoScroll_toEnd();
            });

            // convert QuerySnapShot to List data
            List<ChatMessage> messageData = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              String UserID_sent =
              snapshot.data!.docs[i][FirestoreContants.FromUser_message];

              messageData.add(ChatMessage(
                  roomID: chatProvider.roomId/*widget.roomID*/,
                  FromUser: snapshot.data!.docs[i]
                  [FirestoreContants.FromUser_message],
                  text: snapshot.data!.docs[i][FirestoreContants.text_message],
                  type: snapshot.data!.docs[i][FirestoreContants.type_message],
                  time: snapshot.data!.docs[i]
                  [FirestoreContants.time_message]));
            }

            return ListView.builder(
                controller: _scrollController,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  return messageData[index].FromUser == chatProvider.currentUserId/*widget.currUser.id*/
                      ? itemMessage_Sender(
                    message: messageData[index].text,
                  )
                      : itemMessage_receiver(
                    photo: /*widget.userChat.photo!*/"",
                    message: messageData[index].text,
                    chatProvider: chatProvider,
                  );
                });
          }
        } else
          return Center(
            child: Text("Loading..."),
          );
      },
    );
  }

  // chat input
  Widget chatInputField(ChatProvider chatProvider) {
    return Row(
      children: [
        const SizedBox(width: 10),
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(bottom: 20, top: 10),
            decoration:
                BoxDecoration(color: Colors.grey.withOpacity(0.3), borderRadius: BorderRadius.all(Radius.circular(30))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(width: 15),
                Expanded(
                    child: TextField(
                  onChanged: (text) {
                    if (text.length > 0)
                      setState(() {
                        haveText = true;
                      });
                    else
                      setState(() {
                        haveText = false;
                      });
                  },
                  controller: chatInputController,
                  decoration: const InputDecoration(hintText: 'Type message', border: InputBorder.none),
                )),
                const SizedBox(width: 10),
                InkWell(
                    onTap: () {},
                    child: const Icon(Icons.camera_alt_outlined, color: Color.fromARGB(255, 0, 127, 232), size: 20)),
                const SizedBox(width: 13),
                InkWell(
                    onTap: () {
                      handleSend_message(chatProvider);
                    },
                    child: Icon(Icons.send,
                        color: haveText ? const Color.fromARGB(255, 0, 127, 232) : Colors.grey, size: 20)),
                const SizedBox(width: 13)
              ],
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}

// item message (sender)
class itemMessage_Sender extends StatelessWidget {
  final String message;

  const itemMessage_Sender({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 20, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.end, crossAxisAlignment: CrossAxisAlignment.end, children: [
        Container(
          decoration: const BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(
              message,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
          ),
        ),
        const SizedBox(width: 10),
        const Icon(
          Icons.check_circle,
          color: Color.fromARGB(255, 35, 156, 255),
          size: 14,
        )
      ]),
    );
  }
}

// item message (receiver)
class itemMessage_receiver extends StatelessWidget {
  final String message;
  final String photo;
  final ChatProvider chatProvider;
  const itemMessage_receiver(
      {Key? key,
      required this.message,
      required this.chatProvider,
      required this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
       /* CircleAvatar(
          backgroundImage: AssetImage(photo),
          radius: 17,
        ),*/
        Container(
          margin: const EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.3), borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Padding(
            padding: const EdgeInsets.all(11.0),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 15),
            ),
          ),
        ),
      ]),
    );
  }
}
