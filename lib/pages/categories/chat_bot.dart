import 'package:flutter/material.dart';

import '../chat/message_screen.dart';

class ChatBot extends StatelessWidget {
  const ChatBot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MessageScreen(isChatBot: true),
    );
  }
}
