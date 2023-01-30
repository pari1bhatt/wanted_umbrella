import 'package:wanted_umbrella/utils/firestore_constants.dart';
import 'package:wanted_umbrella/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class ChatProvider extends ChangeNotifier {
  final FirebaseFirestore firestore;

  ChatProvider({required this.firestore});

  Stream<QuerySnapshot> getMessageWithChatroomID(String roomID) {
    return FirebaseFirestore.instance
        .collection(FirestoreContants.messageCollection)
        .where(FirestoreContants.roomID_message, isEqualTo: roomID)
        .snapshots();
  }

  Future<void> sendChatMessage(ChatMessage chatMessage, String roomID) async {
    await firestore
        .collection(FirestoreContants.messageCollection)
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set({
      FirestoreContants.roomID_message: chatMessage.roomID,
      FirestoreContants.FromUser_message: chatMessage.FromUser,
      FirestoreContants.text_message: chatMessage.text,
      FirestoreContants.type_message: chatMessage.type,
      FirestoreContants.time_message: chatMessage.time,
    });
  }

  Stream<QuerySnapshot> getMemberList(List<String> matchList) {
    return FirebaseFirestore.instance
        .collection(FirestoreContants.userCollection)
        .where(FirestoreContants.id_user, whereIn: matchList)
        .snapshots();
  }

  Future<void> createChatRoom(String chatRoomID, chatRoomMap) async {
    await firestore
        .collection(FirestoreContants.roomCollection)
        .add(chatRoomMap);
  }

  Future<QuerySnapshot> getChatRoom(String chatRoomID) async {
    return await firestore
        .collection(FirestoreContants.roomCollection)
        .where(FirestoreContants.roomID_room, isEqualTo: chatRoomID)
        .get();
  }

  // make a chat roomID with alphabetical order
  String getChatRoomID(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$a\_$b";
    } else {
      return "$b\_$a";
    }
  }
}
