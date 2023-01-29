import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wanted_umbrella/models/user_model.dart';
import 'package:wanted_umbrella/routes.dart';
import 'package:wanted_umbrella/utils/constants.dart';

import '../../utils/prefs.dart';

class AdoptADog extends StatefulWidget {
  const AdoptADog({Key? key}) : super(key: key);

  @override
  State<AdoptADog> createState() => _AdoptADogState();
}

class _AdoptADogState extends State<AdoptADog> {
  // late DashboardProvider provider;
  // List<SelectionModel> items = [
  //   SelectionModel(text: 'Bunty - Bulldog', text2: '12, Male', image: GetImages.dog4),
  //   SelectionModel(text: 'Joker - Husky', text2: '5, Female', image: GetImages.dog2_2),
  // ];

  @override
  Widget build(BuildContext context) {
    print('check email: ${Prefs.getUserEmail()}');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Adopt a dog"),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where('email', isNotEqualTo: Prefs.getUserEmail())
              .where('showAdoption', isEqualTo: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData) {
              return Container(
                decoration: const BoxDecoration(
                  // gradient: RadialGradient(colors: [
                  //   Colors.grey[800]!,
                  //   Colors.black,
                  // ], radius: 0.85, focal: Alignment.center),
                ),
                child: GridView.builder(
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 0),
                  itemCount: snapshot.data?.docs.length ?? 0,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, crossAxisSpacing: 3, mainAxisSpacing: 1),
                  itemBuilder: (context, index) {
                    UserModel userModel = UserModel.fromJson(
                        snapshot.data?.docs[index].data() as Map<String, dynamic>);
                      return gridItem(context, userModel);
                  },
                ),
              );
            }
            return const Center(child: Text("there's no Notes"));
          }),
    );
  }

  gridItem(context, UserModel userModel) {
    return Card(
      elevation: 3,
      child: Container(
        color: GetColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: Container(
                    color: GetColors.grey.withOpacity(0.2), child: Image.network(userModel.profile_image!))),
            const SizedBox(height: 5),
            Text('${userModel.dog_name} - ${userModel.breed}', style: const TextStyle(fontSize: 12)),
            Text('${userModel.age} - ${userModel.gender}', style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 5),
            Center(
              child: InkWell(
                onTap: () => successDialog(context, userModel),
                child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        color: GetColors.purple.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8)),
                    child: const Text(
                      "book",
                      style: TextStyle(color: GetColors.white),
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }

  successDialog(context, index) {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.scale,
        title: 'Thank you',
        desc:
            'Dog adopted successfully!!\nplease visit: Wanted umbrella’s Shelter Care Jayanagar, Bangalore.',
        btnCancel: null,
        btnOkOnPress: () => Navigator.popUntil(context, ModalRoute.withName(Routes.dashboard)),
      ).show();
  }
}
