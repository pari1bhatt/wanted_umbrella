import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../models/selection_model.dart';
import '../dashboard_provider.dart';

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
  late DashboardProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<DashboardProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: StreamBuilder<DocumentSnapshot>(
          stream:
              FirebaseFirestore.instance.doc("users/${provider.currentUserModel?.id}").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              UserModel userModel = UserModel.fromJson(snapshot.data?.data() as Map);
              print('userModel ${userModel.breedingRequests.length}');

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 10),
                itemCount: userModel.breedingRequests.length,
                itemBuilder: (context, index) {
                  return listItem(userModel);
                },
              );
            }
            return const Center(child: Text("No notifications"));
          }),
    );
  }

  listItem(UserModel userModel) {
    return Column(
      children: [
        Container(
          height: size.height * 0.1,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  child: Text("${userModel.name} - ${userModel.breed}\nhas requested for a match")),
              Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    // onPressed: userModel.isSelected ? null : () => successDialog(userModel),
                    onPressed: () => successDialog(userModel),
                    style: TextButton.styleFrom(
                      // backgroundColor: userModel.isSelected ? GetColors.grey : GetColors.purple,
                      backgroundColor: GetColors.purple,
                    ),
                    child: const Text("Accept",
                        style: TextStyle(color: GetColors.white)),
                  )),
            ],
          ),
        ),
        const Divider(thickness: 2)
      ],
    );
  }

  successDialog(UserModel userModel) {
    // if (!userModel.isSelected) {
      // setState(() {
      //   userModel.isSelected = true;
      // });
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
    // }
  }
}
