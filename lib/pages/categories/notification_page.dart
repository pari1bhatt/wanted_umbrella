import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/constants.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                height: size.height * 0.1,
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text("Bunty - Husky\nhas requested for a match")),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: successDialog,
                          style: TextButton.styleFrom(backgroundColor: GetColors.purple),
                          child: Text("Accept", style: TextStyle(color: GetColors.white)),
                        )),
                  ],
                ),
              ),
              const Divider(thickness: 2)
            ],
          );
        },
      ),
    );
  }

  successDialog(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.noHeader,
      animType: AnimType.scale,
      dismissOnTouchOutside: false,
      title: 'Success',
      desc: 'I hope you had a good booking experience. Wanted umbrella wishes you all luck\n 😀',
      btnCancel: null,
      btnOkOnPress: () {},
    ).show();
  }
}
