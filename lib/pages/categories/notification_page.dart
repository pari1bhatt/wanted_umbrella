import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/selection_model.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final List<SelectionModel> items = [
    SelectionModel(text: 'Bunty - Husky'),
    SelectionModel(text: 'Joker - Bulldog')
  ];
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
          return listItem(index);
        },
      ),
    );
  }

  listItem(index) {
    return Column(
      children: [
        Container(
          height: size.height * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: Text("${items[index].text}\nhas requested for a match")),
              Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    onPressed: items[index].isSelected ? null : () => successDialog(index),
                    style: TextButton.styleFrom(
                        backgroundColor:
                            items[index].isSelected ? GetColors.grey : GetColors.purple),
                    child: Text(items[index].isSelected ? 'Accepted' : "Accept",
                        style: TextStyle(color: GetColors.white)),
                  )),
            ],
          ),
        ),
        const Divider(thickness: 2)
      ],
    );
  }

  successDialog(index) {
    if (!items[index].isSelected) {
      setState(() {
        items[index].isSelected = true;
      });
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        dismissOnTouchOutside: false,
        title: 'Success',
        desc: 'I hope you had a good booking experience. Wanted umbrella wishes you all luck\n 😀',
        btnCancel: null,
        btnOkOnPress: () {},
      ).show();
    }
  }
}
