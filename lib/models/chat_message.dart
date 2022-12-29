class ChatMessage {
  final String roomID;
  final String FromUser;
  final String text;
  final String type;
  final String time;

  ChatMessage(
      {required this.roomID,
        required this.FromUser,
        required this.text,
        required this.type,
        required this.time});
}
