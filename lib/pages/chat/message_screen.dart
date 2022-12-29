import 'package:flutter/material.dart';
import 'package:wanted_umbrella/models/chat_message.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class MessageScreen extends StatefulWidget {
  final bool isChatBot;

  const MessageScreen({this.isChatBot = false, Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final chatInputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool haveText = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppbar(context),
      body: buildBody(context),
    );
  }

  // appbar
  AppBar buildAppbar(BuildContext context) {
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
                      "Bunty",
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
  SafeArea buildBody(BuildContext context) {
    return SafeArea(
        child: Container(
      color: Colors.grey.withOpacity(0.00),
      child: Column(
        children: [
          Expanded(
            child: ChatMessageList(),
          ),
          chatInputField(),
        ],
      ),
    ));
  }

  // list message
  Widget ChatMessageList() {
    if (true) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(widget.isChatBot ? GetImages.robot_icon : GetImages.dog3),
              radius: 50,
              backgroundColor: GetColors.purple.withOpacity(0.2),
            ),
            const SizedBox(height: 10),
            Text(
              widget.isChatBot ? "Chatbot" :"Bunty",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            Text(widget.isChatBot ? "Ask Something..." : "Say hello..."),
            const SizedBox(height: 20),
          ],
        ),
      );
    } else {
      // convert QuerySnapShot to List data
      List<ChatMessage> messageData = [];
      for (int i = 0; i < 6; i++) {
        String UserIDSent = "user_id";

        messageData.add(ChatMessage(
          roomID: "2",
          FromUser: "FromUser$i",
          text: "Sample text message",
          type: "type",
          time: "time",
        ));
      }

      return ListView.builder(
          controller: _scrollController,
          itemCount: 6,
          itemBuilder: (context, index) {
            return messageData[index].FromUser == "FromUser5"
                ? itemMessage_Sender(
                    message: messageData[index].text,
                  )
                : itemMessage_receiver(
                    photo: GetImages.dog4,
                    message: messageData[index].text,
                    // chatProvider: chatProvider,
                  );
          });
    }
  }

  // chat input
  Widget chatInputField() {
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
                    // if (text.length > 0)
                    //   setState(() {
                    //     haveText = true;
                    //   });
                    // else
                    //   setState(() {
                    //     haveText = false;
                    //   });
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
                      // handleSend_message(chatProvider);
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

  // final ChatProvider chatProvider;
  const itemMessage_receiver(
      {Key? key,
      required this.message,
      // required this.chatProvider,
      required this.photo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        CircleAvatar(
          backgroundImage: AssetImage(photo),
          radius: 17,
        ),
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
