import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/utils/constants.dart';
import '../dashboard_provider.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late Size size;
  late DashboardProvider provider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    provider = Provider.of<DashboardProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Notifications"),
      ),
      body: (provider.currentUserModel?.breedingRequests.isEmpty ?? true)
          ? Center(child: Text('No Notifications'))
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: provider.currentUserModel?.breedingRequests.length ?? 0,
              itemBuilder: (context, index) {
                return listItem(
                    context, provider.currentUserModel?.breedingRequests[index].id, index);
              },
            ),
    );
  }

  listItem(context, id, index) {
    return FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.doc("users/$id").get(),
        builder: (ctx, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text("Document does not exist");
          }
          if (snapshot.connectionState == ConnectionState.done) {
            UserModel innerModel = UserModel.fromJson(snapshot.data?.data() as Map);
            innerModel.id = snapshot.data?.id;
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${innerModel.name} has requested for a match"),
                      Text("Dog name: ${innerModel.dog_name}"),
                      Text("Dog breed: ${innerModel.breed}"),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            // onPressed: userModel.isSelected ? null : () => successDialog(userModel),
                            onPressed: () => provider.acceptBreedingRequest(context, innerModel.id),
                            style: TextButton.styleFrom(
                              backgroundColor: GetColors.purple,
                            ),
                            child: const Text("Accept", style: TextStyle(color: GetColors.white)),
                          )),
                    ],
                  ),
                ),
                const Divider(thickness: 2)
              ],
            );
          }
          return Container();
        });
  }
}
